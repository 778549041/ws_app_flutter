import 'package:get/get.dart';
import 'package:ws_app_flutter/view_models/car/nav_map_controller.dart';
import 'package:ws_app_flutter/view_models/circle/add_friend_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_detail_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_msg_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_publish_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_search_controller.dart';
import 'package:ws_app_flutter/view_models/circle/circle_topic_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/friends_controller.dart';
import 'package:ws_app_flutter/view_models/circle/profile_controller.dart';
import 'package:ws_app_flutter/view_models/circle/report_controller.dart';
import 'package:ws_app_flutter/view_models/circle/single_user_circle_list_controller.dart';
import 'package:ws_app_flutter/view_models/circle/topic_controller.dart';
import 'package:ws_app_flutter/view_models/login/bind_controller.dart';
import 'package:ws_app_flutter/view_models/login/certify_controller.dart';
import 'package:ws_app_flutter/view_models/login/complaint_controller.dart';
import 'package:ws_app_flutter/view_models/login/complete_info_controller.dart';
import 'package:ws_app_flutter/view_models/login/login_controller.dart';
import 'package:ws_app_flutter/view_models/login/select_intrest_controller.dart';
import 'package:ws_app_flutter/view_models/main/main_controller.dart';
import 'package:ws_app_flutter/view_models/mine/add_shop_controller.dart';
import 'package:ws_app_flutter/view_models/mine/bind_new_phone_controller.dart';
import 'package:ws_app_flutter/view_models/mine/change_area_controller.dart';
import 'package:ws_app_flutter/view_models/mine/change_name_cotroller.dart';
import 'package:ws_app_flutter/view_models/mine/chat_controller.dart';
import 'package:ws_app_flutter/view_models/mine/conversation_controller.dart';
import 'package:ws_app_flutter/view_models/mine/msg_center_controller.dart';
import 'package:ws_app_flutter/view_models/mine/sign_controller.dart';
import 'package:ws_app_flutter/view_models/mine/unbind_phone_controller.dart';
import 'package:ws_app_flutter/view_models/mine/change_pwd_controller.dart';
import 'package:ws_app_flutter/view_models/mine/feedback_controller.dart';
import 'package:ws_app_flutter/view_models/mine/mine_info_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_auth_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_changepwd_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pay_confirm_controller.dart';
import 'package:ws_app_flutter/view_models/mine/pwd_manage_controller.dart';
import 'package:ws_app_flutter/view_models/mine/setting_controller.dart';
import 'package:ws_app_flutter/view_models/mine/shop_list_controller.dart';
import 'package:ws_app_flutter/view_models/net/net_controller.dart';
import 'package:ws_app_flutter/view_models/wow/activity_search_controller.dart';
import 'package:ws_app_flutter/view_models/wow/cate_news_controller.dart';
import 'package:ws_app_flutter/view_models/wow/ele_list_controller.dart';
import 'package:ws_app_flutter/view_models/wow/near_dz_map_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_detail_controller.dart';
import 'package:ws_app_flutter/view_models/wow/news_search_controller.dart';
import 'package:ws_app_flutter/views/car/air_condition_page.dart';
import 'package:ws_app_flutter/views/car/door_lock_page.dart';
import 'package:ws_app_flutter/views/car/dz_introduce_page.dart';
import 'package:ws_app_flutter/views/car/nav_map_page.dart';
import 'package:ws_app_flutter/views/car/vitual_control_page.dart';
import 'package:ws_app_flutter/views/circle/add_friends_page.dart';
import 'package:ws_app_flutter/views/circle/circle_detail_page.dart';
import 'package:ws_app_flutter/views/circle/circle_msg_page.dart';
import 'package:ws_app_flutter/views/circle/circle_publish_page.dart';
import 'package:ws_app_flutter/views/circle/circle_search_page.dart';
import 'package:ws_app_flutter/views/circle/circle_topic_list_page.dart';
import 'package:ws_app_flutter/views/circle/friends_list_page.dart';
import 'package:ws_app_flutter/views/circle/profile_page.dart';
import 'package:ws_app_flutter/views/circle/report_know_page.dart';
import 'package:ws_app_flutter/views/circle/report_page.dart';
import 'package:ws_app_flutter/views/circle/single_user_circle_page.dart';
import 'package:ws_app_flutter/views/circle/topic_list_page.dart';
import 'package:ws_app_flutter/views/login/bind_phone_page.dart';
import 'package:ws_app_flutter/views/login/certify_page.dart';
import 'package:ws_app_flutter/views/login/complaint_page.dart';
import 'package:ws_app_flutter/views/login/complete_info_page.dart';
import 'package:ws_app_flutter/views/login/login_page.dart';
import 'package:ws_app_flutter/views/login/select_intrest_page.dart';
import 'package:ws_app_flutter/views/main/tabbar_page.dart';
import 'package:ws_app_flutter/views/mine/add_shop_page.dart';
import 'package:ws_app_flutter/views/mine/bind_new_phone_page.dart';
import 'package:ws_app_flutter/views/mine/change_area_page.dart';
import 'package:ws_app_flutter/views/mine/change_name_page.dart';
import 'package:ws_app_flutter/views/mine/chat_page.dart';
import 'package:ws_app_flutter/views/mine/mine_friends_page.dart';
import 'package:ws_app_flutter/views/mine/msg_center_page.dart';
import 'package:ws_app_flutter/views/mine/sign_page.dart';
import 'package:ws_app_flutter/views/mine/unbind_phone_page.dart';
import 'package:ws_app_flutter/views/mine/change_pwd_page.dart';
import 'package:ws_app_flutter/views/mine/feed_back_page.dart';
import 'package:ws_app_flutter/views/mine/mine_info_page.dart';
import 'package:ws_app_flutter/views/mine/mine_qr_page.dart';
import 'package:ws_app_flutter/views/mine/pay_auth.dart';
import 'package:ws_app_flutter/views/mine/pay_change_pwd.dart';
import 'package:ws_app_flutter/views/mine/pay_confirm_pwd.dart';
import 'package:ws_app_flutter/views/mine/phone_page.dart';
import 'package:ws_app_flutter/views/mine/pwd_manage_page.dart';
import 'package:ws_app_flutter/views/mine/setting_page.dart';
import 'package:ws_app_flutter/views/mine/shop_address_list_page.dart';
import 'package:ws_app_flutter/views/scan_page.dart';
import 'package:ws_app_flutter/views/webview_page.dart';
import 'package:ws_app_flutter/views/wow/activity_search_page.dart';
import 'package:ws_app_flutter/views/wow/cate_news_list_page.dart';
import 'package:ws_app_flutter/views/wow/ele_list_page.dart';
import 'package:ws_app_flutter/views/wow/near_dz_map_page.dart';
import 'package:ws_app_flutter/views/wow/news_detail_page.dart';
import 'package:ws_app_flutter/views/wow/news_search_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    //tabbar主页
    GetPage(
      name: Routes.HOME,
      page: () => MainTabBarPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<MainController>(() => MainController()),
      ),
    ),
    //web网页
    GetPage(
      name: Routes.WEBVIEW,
      page: () => WebViewPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NetConnectController>(() => NetConnectController()),
      ),
    ),
    //登录页
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<LoginController>(() => LoginController()),
      ),
    ),
    //修改、忘记密码
    GetPage(
      name: Routes.CHANGEPWD,
      page: () => ChangePwdPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ChangePwdController>(() => ChangePwdController()),
      ),
    ),
    //绑定手机号
    GetPage(
      name: Routes.BINDPHONE,
      page: () => BindPhonePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<BindController>(() => BindController()),
      ),
    ),
    //完善信息
    GetPage(
      name: Routes.COMPLETEINFO,
      page: () => CompleteInfoPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<CompleteInfoController>(() => CompleteInfoController()),
      ),
    ),
    //选择、修改兴趣爱好
    GetPage(
      name: Routes.SELECTINTREST,
      page: () => SelectIntrestPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SelectIntreController>(() => SelectIntreController()),
      ),
    ),
    //手动留资认证车主
    GetPage(
      name: Routes.CERTIFY,
      page: () => CertifyPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CertifyController>(() => CertifyController()),
      ),
    ),
    //主动认证申诉页
    GetPage(
      name: Routes.COMPLAINT,
      page: () => ComplaintPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ComplaintController>(() => ComplaintController()),
      ),
    ),
    //设置
    GetPage(
      name: Routes.SETTING,
      page: () => SettingPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SettingController>(() => SettingController()),
      ),
    ),
    //密码管理
    GetPage(
      name: Routes.PWDMANAGE,
      page: () => PwdManagePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<PwdManageController>(() => PwdManageController()),
      ),
    ),
    //修改支付密码授权
    GetPage(
      name: Routes.PAYAUTH,
      page: () => PayAuthPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<PayAuthController>(() => PayAuthController()),
      ),
    ),
    //修改支付密码
    GetPage(
      name: Routes.PAYCHANGEPWD,
      page: () => PayChangePwdPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<PayChangePwdController>(() => PayChangePwdController()),
      ),
    ),
    //确认支付密码
    GetPage(
      name: Routes.PAYCONFIRMPWD,
      page: () => PayPwdConfirmPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<PayConfirmController>(() => PayConfirmController()),
      ),
    ),
    //意见反馈
    GetPage(
      name: Routes.FEEDBACK,
      page: () => FeedBackPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<FeedBackController>(() => FeedBackController()),
      ),
    ),
    //个人信息
    GetPage(
      name: Routes.MINEINFO,
      page: () => MineInfoPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<MineInfoController>(() => MineInfoController()),
      ),
    ),
    //我的二维码
    GetPage(name: Routes.MINEQR, page: () => MineQRPage()),
    //修改昵称和职业
    GetPage(
      name: Routes.MINECHANGENAME,
      page: () => ChangeNamePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ChangeNameController>(() => ChangeNameController()),
      ),
    ),
    //修改现居地
    GetPage(
      name: Routes.MINECHANGEAREA,
      page: () => ChangeAreaPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ChangeAreaController>(() => ChangeAreaController()),
      ),
    ),
    //修改手机号
    GetPage(name: Routes.MINEPHONE, page: () => PhonePage()),
    //解除当前绑定手机号
    GetPage(
      name: Routes.MINEUNBINDPHONE,
      page: () => UnbindPhonePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<UnbindPhoneController>(() => UnbindPhoneController()),
      ),
    ),
    //绑定新手机号
    GetPage(
      name: Routes.MINEBINDNEWPHONE,
      page: () => BindNewPhonePage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<BindNewPhoneController>(() => BindNewPhoneController()),
      ),
    ),
    //我的收获地址列表
    GetPage(
      name: Routes.MINESHOPADDRLIST,
      page: () => ShopAddressListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ShopListController>(() => ShopListController()),
      ),
    ),
    //添加、修改收获地址
    GetPage(
      name: Routes.MINEADDSHOP,
      page: () => AddShopPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AddShopController>(() => AddShopController()),
      ),
    ),
    //消息中心
    GetPage(
      name: Routes.MSGCENTER,
      page: () => MsgCenterPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<MsgCenterController>(() => MsgCenterController()),
      ),
    ),
    //扫码页面
    GetPage(
      name: Routes.SCAN,
      page: () => ScanPage(),
    ),
    //聊天页面
    GetPage(
      name: Routes.CHAT,
      page: () => ChatPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ChatController>(() => ChatController()),
      ),
    ),
    //个人中心我的好友（聊天会话列表）
    GetPage(
      name: Routes.MINEFRIENDS,
      page: () => MineFriendsPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<ConversationController>(() => ConversationController()),
      ),
    ),
    //签到
    GetPage(
      name: Routes.SIGNPAGE,
      page: () => SignPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<SignController>(() => SignController()),
      ),
    ),
    //车主附近电桩
    GetPage(
      name: Routes.NEARDZMAP,
      page: () => NearDZMapPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NearDZMapController>(() => NearDZMapController()),
      ),
    ),
    //充电站列表
    GetPage(
      name: Routes.NEARDZLIST,
      page: () => EleListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<EleListController>(() => EleListController()),
      ),
    ),
    //非车主附近电桩介绍页
    GetPage(
      name: Routes.DZINTRODUCE,
      page: () => DZIntroducePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NearDZMapController>(() => NearDZMapController()),
      ),
    ),
    //实时导航
    GetPage(
      name: Routes.NAVMAP,
      page: () => NavMapPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NavMapController>(() => NavMapController()),
      ),
    ),
    //单个分类下的资讯列表
    GetPage(
      name: Routes.CATENEWSLIST,
      page: () => CateNewsListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CateNewsController>(() => CateNewsController()),
      ),
    ),
    //资讯搜索
    GetPage(
      name: Routes.NEWSSEARCH,
      page: () => NewsSearchPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NewsSearchController>(() => NewsSearchController()),
      ),
    ),
    //活动搜索
    GetPage(
      name: Routes.ACTIVITYSEARCH,
      page: () => ActivitySearchPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ActivitySearchController>(
            () => ActivitySearchController()),
      ),
    ),
    //资讯详情
    GetPage(
      name: Routes.NEWSDETAIL,
      page: () => NewsDetailPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<NewsDetailController>(() => NewsDetailController()),
      ),
    ),
    //好友详情
    GetPage(
      name: Routes.USERPROFILE,
      page: () => ProfilePage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ProfileController>(() => ProfileController()),
      ),
    ),
    //圈子搜索
    GetPage(
      name: Routes.CIRCLESEARCH,
      page: () => CircleSearchPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<CircleSearchController>(() => CircleSearchController()),
      ),
    ),
    //添加好友
    GetPage(
      name: Routes.ADDFRIEND,
      page: () => AddFriendPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AddFriendsController>(() => AddFriendsController()),
      ),
    ),
    //好友列表
    GetPage(
      name: Routes.FRIENDSLIST,
      page: () => FriendsListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<FriendsController>(() => FriendsController()),
      ),
    ),
    //圈子详情
    GetPage(
      name: Routes.CIRCLEDETAIL,
      page: () => CircleDetailPage(),
      binding: BindingsBuilder(
        () =>
            Get.lazyPut<CircleDetailController>(() => CircleDetailController()),
      ),
    ),
    //圈子消息中心
    GetPage(
      name: Routes.CIRCLMSG,
      page: () => CircleMsgPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CircleMsgController>(() => CircleMsgController()),
      ),
    ),
    //发布圈子
    GetPage(
      name: Routes.CIRCLPUBLISH,
      page: () => CirclePublishPage(),
      transition: Transition.downToUp,
      binding: BindingsBuilder(
        () => Get.lazyPut<CirclePublishController>(
            () => CirclePublishController()),
      ),
    ),
    //话题圈子列表
    GetPage(
      name: Routes.CIRCLTOPICLIST,
      page: () => CircleTopicListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<CircleTopicListController>(
            () => CircleTopicListController()),
      ),
    ),
    //单个用户圈子列表
    GetPage(
      name: Routes.SINGLECIRCLELIST,
      page: () => SingleUserCircleListPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SingleUserCircleController>(
            () => SingleUserCircleController()),
      ),
    ),
    //举报须知
    GetPage(name: Routes.REPORTKNOW, page: () => ReportKnowPage()),
    //举报
    GetPage(
      name: Routes.REPORT,
      page: () => ReportPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ReportController>(() => ReportController()),
      ),
    ),
    //话题列表
    GetPage(
      name: Routes.TOPICLIST,
      page: () => TopicListPage(),
      transition: Transition.downToUp,
      binding: BindingsBuilder(
        () => Get.lazyPut<TopicController>(() => TopicController()),
      ),
    ),
    //门锁详情
    GetPage(name: Routes.DOORLOCK, page: () => DoorLockPage()),
    //空调详情
    GetPage(name: Routes.AIRCONDITION, page: () => AirConditionPage()),
    //虚拟体验
    GetPage(name: Routes.VITUALCONTROL, page: () => VitualControlPage()),
  ];
}
