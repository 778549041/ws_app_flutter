import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/circle/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  final String userId =
      Get.arguments == null ? null : Get.arguments['user_id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}