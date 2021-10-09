import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/circle_tag_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/views/circle/faq_tab_tag_list_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class FaqTabListPage extends StatefulWidget {
  final int type; //列表类型，0热门问答，1随便看看，2往期热点

  FaqTabListPage(this.type);

  @override
  FaqTabListPageState createState() => FaqTabListPageState();
}

class FaqTabListPageState extends State<FaqTabListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  List<CircleTagModel> tabsData = <CircleTagModel>[];
  int? year;
  int? month;
  int? maxYear;
  int? maxMonth;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabsData.map((e) {
              return Tab(
                text: e.title,
              );
            }).toList(),
            labelColor: Colors.white,
            unselectedLabelColor: MainAppColor.secondaryTextColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 30,
              indicatorRadius: 15,
              indicatorColor: Color(0xFF1B7DF4),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
        if (widget.type == 2)
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: CustomButton(
              width: 100,
              height: 25,
              title: '$year年$month月',
              fontSize: 12,
              titleColor: Color(0xFF1B7DF4),
              borderColor: Color(0xFF1B7DF4),
              borderWidth: 0.5,
              image: 'assets/images/circle/blue_down_arrow.png',
              imageW: 10,
              imageH: 5,
              imagePosition: XJImagePosition.XJImagePositionRight,
              radius: 3,
              onPressed: () => selectDate(context),
            ),
          ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabsData.map((e) {
              return FaqTabTagListPage(
                type: widget.type,
                tagId: e.tag_id!,
                year: year,
                month: month,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _tabController = TabController(
      length: tabsData.length,
      vsync: this,
    );
    super.initState();
    if (widget.type == 2) {
      DateTime dateTime = DateTime.now();
      year = maxYear = dateTime.year;
      month = maxMonth = dateTime.month - 1;
    }
    getFaqTagListData();
  }

  //选择日期
  void selectDate(BuildContext context) {
    Pickers.showDatePicker(
      context,
      mode: DateMode.YM,
      selectDate: PDuration(year: year,month: month),
      minDate: PDuration(year: 2021, month: 5),
      maxDate: PDuration(year: maxYear, month: maxMonth),
      onConfirm: (res) {
        setState(() {
          year = res.year;
          month = res.month;
        });
      },
    );
  }

  //用户圈子标签分类数据
  Future getFaqTagListData() async {
    CircleTagListModel tagListModel = await DioManager()
        .request<CircleTagListModel>(DioManager.GET, Api.allFAQTagsListUrl);
    tabsData.clear();
    setState(() {
      tabsData.addAll(tagListModel.data!);
      _tabController = TabController(
        length: tabsData.length,
        vsync: this,
      );
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FaqTabListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
