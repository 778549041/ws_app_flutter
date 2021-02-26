import 'package:ws_app_flutter/models/wow/news_model.dart';
import 'package:ws_app_flutter/models/wow/news_tag_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/refresh_list_controller.dart';
import 'package:get/get.dart';

class NewsSearchController extends RefreshListController<NewModel> {
  var searchType = 0.obs; //搜索类型，默认0未搜索状态，1输入内容搜索，2选择tag搜索
  var selectedTag = ''.obs; //当前选中的tag,默认-1
  var searchKey = ''.obs; //搜索关键字
  List<NewsTagModel> _data = List<NewsTagModel>(); //标签数据
  var searchTagList = List<NewsTagModel>().obs; //标签数据

  @override
  void onInit() async {
    pageSize = 5;
    await newsSearchTagData();
    // super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<List<NewModel>> loadData({int pageNum}) async {
    String _url = '';
    Map<String, dynamic> _params = Map<String, dynamic>();
    if (searchType.value == 0) {
      return null;
    } else if (searchType.value == 1) {
      //1输入内容搜索
      _url = Api.newsSearchWithKeyUrl;
      _params['page'] = pageNum;
      _params['search'] = searchKey.value;
    } else if (searchType.value == 2) {
      //2选择tag搜索
      _url = Api.newsSearchWithTagUrl;
      _params['page'] = pageNum;
      _params['tid'] = selectedTag.value;
    }
    NewsListModel obj = await DioManager()
        .request<NewsListModel>(DioManager.GET, _url, queryParamters: _params);
    return obj.list;
  }

  Future newsSearchTagData() async {
    NewsTagListModel _model = await DioManager()
        .request<NewsTagListModel>(DioManager.GET, Api.newsSearchTagUrl);
    _data.addAll(_model.list);
    searchTagList.assignAll(_model.list);
  }

  Future inputSearch(String input) async {
    searchKey.value = input;
    searchType.value = 1;
    refresh();
  }

  void selectItem(index) {
    searchTagList.clear();
    for (var i = 0; i < _data.length; i++) {
      if (i == index) {
        _data[i].selected = true;
      } else {
        _data[i].selected = false;
      }
      searchTagList.add(_data[i]);
      selectedTag.value = _data[i].tagId;
      searchType.value = 2;
      refresh();
    }
  }
}
