import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/models/circle/friend_model.dart';
import 'package:ws_app_flutter/utils/circle_action_util.dart';
import 'package:ws_app_flutter/view_models/circle/add_friend_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/round_avatar.dart';

class AddFriendPage extends GetView<AddFriendsController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '添加好友',
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 35,
                    child: TextField(
                      controller: controller.textEditingController,
                      focusNode: controller.focusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: MainAppColor.secondaryTextColor,
                                  width: 0.5)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8)),
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
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => controller.doSearch(),
                  child: Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFF1B7DF4),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/circle/icon_search_white.png',
                          width: 17,
                          height: 17,
                        ),
                        Text(
                          '搜索',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  Obx(
                    () => SliverToBoxAdapter(
                      child: Offstage(
                        offstage: controller.isActive.value,
                        child: Container(
                          height: 50,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '猜您可能感兴趣的人',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF1B7DF4),
                                    ),
                                  ),
                                  CustomButton(
                                    backgroundColor: Colors.transparent,
                                    width: 30,
                                    height: 30,
                                    image:
                                        'assets/images/circle/circle_refresh.png',
                                    imageH: 20,
                                    imageW: 20,
                                    onPressed: () => controller.refresh(),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: MainAppColor.secondaryTextColor,
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        FriendMember member = controller.showListData[index];
                        return GestureDetector(
                          onTap: () => controller.addFriend(member),
                          behavior: HitTestBehavior.translucent,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    RoundAvatar(
                                      imageUrl: member.avatar,
                                      height: 46,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  member.nickname,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              //销售员或者勋章标签
                                              if (member.memberInfo.showTag)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: CustomButton(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    width: 30,
                                                    height: 30,
                                                    image: member.memberInfo
                                                        .medalOrSaleImageName,
                                                    onPressed: () =>
                                                        CircleActionUtil()
                                                            .clickMedal(),
                                                  ),
                                                ),
                                              Offstage(
                                                offstage:
                                                    member.sex.length == 0,
                                                child: Image.asset(
                                                  member.sex == '0'
                                                      ? 'assets/images/mine/woman.png'
                                                      : 'assets/images/mine/man.png',
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 30,
                                            width: Get.width - 160,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                String item =
                                                    member.interest[index];
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  width: 80,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: MainAppColor
                                                        .mainBlueBgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: member.interest.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomButton(
                                      backgroundColor: Colors.transparent,
                                      width: 64,
                                      height: 28,
                                      borderColor: Color(0xFF1B7DF4),
                                      title: '加好友',
                                      titleColor: Color(0xFF1B7DF4),
                                      fontSize: 13,
                                      borderWidth: 1.0,
                                      radius: 5,
                                      onPressed: () =>
                                          controller.addFriend(member),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color(0xFFD6D6D6),
                                height: 0.5,
                              ),
                            ],
                          ),
                        );
                      }, childCount: controller.showListData.length),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
