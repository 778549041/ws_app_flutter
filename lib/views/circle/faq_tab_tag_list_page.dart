import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/faq_list_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/view_state_widget.dart';

class FaqTabTagListPage extends StatefulWidget {
  final int type; //列表类型，0热门问答，1随便看看，2往期热点
  final int tagId; //标签id
  final int? year;
  final int? month;

  FaqTabTagListPage(
      {required this.type, required this.tagId, this.year, this.month});

  @override
  FaqTabTagListPageState createState() => FaqTabTagListPageState();
}

class FaqTabTagListPageState extends State<FaqTabTagListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int pageNum = 1;
  List<FAQModel> data = <FAQModel>[];

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: widget.type == 1 ? true : false,
      onRefresh: () {
        pageNum = 1;
        loadData();
      },
      onLoading: () {
        pageNum++;
        loadData();
      },
      child: CustomScrollView(
        slivers: <Widget>[
          if (data.isEmpty)
            SliverToBoxAdapter(
              child: ViewStateEmptyWidget(
                image: 'assets/images/common/empty.png',
                message: '空空如也',
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 100,
                    color: Colors.red,
                  ),
                );
              }, childCount: data.length),
            ),
        ],
      ),
    );
  }

  /// 加载数据
  Future loadData() async {
    late FAQListModel model;
    if (widget.type == 0) {
      //热门问答数据
      model = await DioManager().request<FAQListModel>(
          DioManager.POST, Api.hotFAQListUrl,
          params: {'type_id': widget.tagId});
    } else if (widget.type == 1) {
      //随便看看数据
      model = await DioManager().request<FAQListModel>(
          DioManager.POST, Api.casuallyFAQListUrl,
          params: {'type_id': widget.tagId, 'page': pageNum});
    } else if (widget.type == 2) {
      //往期热点数据
      model = await DioManager().request<FAQListModel>(
          DioManager.POST, Api.pastHotFAQListUrl,
          params: {
            'type_id': widget.tagId,
            'year': widget.year! < 10 ? '0${widget.year}' : '${widget.year}',
            'month': widget.month! < 10 ? '0${widget.month}' : '${widget.month}'
          });
    }

    if (pageNum == 1) {
      _refreshController.refreshCompleted();
      setState(() {
        data.clear();
      });
    } else {
      if (model.total_page == pageNum) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    }
    setState(() {
      data.addAll(model.data!);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(FaqTabTagListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
