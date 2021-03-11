import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/friend_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/view_models/circle/friends_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/car/medal_widget.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class FriendsListPage extends GetView<FriendsController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的好友',
      bgColor: Colors.transparent,
      rightActions: <Widget>[
        CustomButton(
          backgroundColor: Colors.transparent,
          width: 40,
          height: 40,
          image: 'assets/images/mine/mine_add_friend.png',
          imageW: 20,
          imageH: 20,
          onPressed: () {
            //添加好友
            Get.toNamed(Routes.ADDFRIEND);
          },
        )
      ],
      child: Stack(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.only(top: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Obx(
                  () => AzListView(
                    data: controller.showListData,
                    itemCount: controller.showListData.length,
                    itemBuilder: (context, index) {
                      FriendMember member = controller.showListData[index];
                      return _buildListItem(member);
                    },
                    physics: BouncingScrollPhysics(),
                    indexBarData:
                        SuspensionUtil.getTagIndexList(controller.showListData),
                    indexHintBuilder: (context, tag) {
                      return Container();
                    },
                    indexBarMargin: EdgeInsets.all(10),
                  ),
                ),
              )),
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Container(
              alignment: Alignment.center,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xFFCCCCCC), width: 0.5),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/wow/icon_search_grey.png',
                    width: 15,
                    height: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.textEditingController,
                      focusNode: controller.focusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        hintText: '输入手机号或昵称查找好友',
                        hintStyle:
                            TextStyle(color: Color(0xFF999999), fontSize: 16),
                      ),
                      onChanged: (value) {
                        controller.searchKey = value;
                        if (value.length == 0) {
                          controller.isActive.value = false;
                          controller.showListData.assignAll(controller.list);
                        }
                      },
                      onSubmitted: (value) => controller.doSearch(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(FriendMember member) {
    return GestureDetector(
      onTap: () => controller.pushFriendDetail(member),
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Column(
          children: <Widget>[
            Offstage(
              offstage: member.isShowSuspension != true,
              child: _buildSusWidget(member.getSuspensionTag()),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                RoundAvatar(
                  imageUrl: member.avatar,
                  height: 40,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    member.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                //销售员或者勋章标签
                if (member.memberInfo.showTag)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MedalWidget(
                      medalBtnImage: member.memberInfo.medalOrSaleImageName,
                      medalToastImage:
                          member.memberInfo.medalOrSaleDescImageName,
                    ),
                  ),
                Offstage(
                  offstage: member.sex.length == 0,
                  child: Image.asset(
                    member.sex == '0'
                        ? 'assets/images/mine/woman.png'
                        : 'assets/images/mine/man.png',
                    width: 15,
                    height: 15,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 9.5,
            ),
            Divider(
              color: MainAppColor.seperatorLineColor,
              indent: 65,
              height: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 40,
      width: double.infinity,
      color: Color(0xFFECECEC),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
