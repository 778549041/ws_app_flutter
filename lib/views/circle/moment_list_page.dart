import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ws_app_flutter/models/circle/moment_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/circle/circle_list_item.dart';

class MomentListPage extends StatefulWidget {
  final int tagId;

  MomentListPage({required this.tagId});

  @override
  MomentListPageState createState() => MomentListPageState();
}

class MomentListPageState extends State<MomentListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int pageNum = 1;
  List<MomentModel> data = <MomentModel>[];

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () {
        pageNum++;
        loadData();
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: CircleListItem(
                  model: data[index],
                  pageName: '${widget.tagId}标签circleList',
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
    MomentListModel model = await DioManager().request<MomentListModel>(
        DioManager.POST, Api.newVersionMomentListUrl,
        params: {'page': pageNum, 'tag_id': widget.tagId});
    if (pageNum == 1) {
      setState(() {
        data.clear();
      });
    }
    setState(() {
      data.addAll(model.list!);
    });
    if (model.totalPage! == pageNum) {
      _refreshController.loadNoData();
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MomentListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
