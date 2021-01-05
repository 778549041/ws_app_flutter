import 'package:flutter/material.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';

class CompleteInfoController extends BaseController {
  TextEditingController nameController;
  TextEditingController professionController;

  @override
  void onInit() {
    nameController = TextEditingController();
    professionController = TextEditingController();
    super.onInit();
  }
}