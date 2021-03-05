import 'package:flutter/material.dart';
import 'package:ws_app_flutter/view_models/base/list_controller.dart';

class AddFriendsController extends ListController {
  FocusNode focusNode;
  TextEditingController textEditingController;
  String searchKey;

  @override
  void onInit() {
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    // await getMomentDetailData();
    super.onReady();
  }
  
  @override
  Future<List> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
  
}
