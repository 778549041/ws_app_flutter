part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home'; //tabbar主页
  static const WEBVIEW = '/web-view'; //web网页
  //登录部分
  static const LOGIN = '/login'; //登录页
  static const CHANGEPWD = '/change-pwd'; //修改、忘记密码
  static const BINDPHONE = '/bind-phone'; //绑定手机号
  static const COMPLAINT = '/complaint'; //主动认证申诉页
  static const COMPLETEINFO = '/complete-info'; //完善信息
  static const CERTIFY = '/certify'; //手动留资认证车主
  static const SELECTINTREST = '/select-intrest'; //选择、修改兴趣爱好
  //个人中心部分
  static const SETTING = '/setting'; //设置
  static const PWDMANAGE = '/pwd-manage'; //密码管理
  static const FEEDBACK = '/feedback'; //意见反馈
  static const PAYAUTH = '/pay-pwd-auth'; //修改支付密码授权
  static const PAYCHANGEPWD = '/pay-change-pwd'; //修改支付密码
  static const PAYCONFIRMPWD = '/pay-confirm-pwd'; //确认支付密码
  static const MINEINFO = '/mine-info'; //个人信息
  static const MINEQR = '/mine-qr'; //我的二维码
  static const MINECHANGENAME = '/mine-change-name'; //修改昵称和职业
  static const MINECHANGEAREA = '/mine-change-area'; //修改现居地
  static const MINEPHONE = '/mine-phone'; //修改手机号
  static const MINEUNBINDPHONE = '/mine-unbind-phone'; //解除当前绑定手机号
  static const MINEBINDNEWPHONE = '/mine-bind-new-phone'; //绑定新手机号
  static const MINESHOPADDRLIST = '/mine-shop-addr-list'; //我的收获地址列表
  static const MINEADDSHOP = '/mine-add-shop'; //添加、修改收获地址
  static const MSGCENTER = '/mine-msg-center'; //消息中心
  static const SCAN = '/mine-scan'; //扫码页面
  static const CHAT = '/chat'; //聊天页面
  static const MINEFRIENDS = '/mine-friends'; //个人中心我的好友（聊天会话列表）
  static const SIGNPAGE = '/sign-page';//签到
  //wow
  static const NEARDZMAP = '/near-dz-map'; //车主附近电桩
  static const NEARDZLIST = '/near-dz-list'; //充电站列表
  static const DZINTRODUCE = '/dz-introduce'; //非车主附近电桩介绍页
  static const NAVMAP = '/nav-map'; //实时导航
  static const CATENEWSLIST = '/cate-news-list'; //单个分类下的资讯列表
  static const NEWSSEARCH = '/news-search'; //资讯搜索
  static const ACTIVITYSEARCH = '/activity-search'; //活动搜索
  static const NEWSDETAIL = '/news-detail'; //资讯详情
  //圈子
  static const USERPROFILE = '/user-profile'; //好友详情
  static const CIRCLESEARCH = '/circle-search'; //圈子搜索
  static const ADDFRIEND = '/add-friend'; //添加好友
  static const FRIENDSLIST = '/friends-list'; //好友列表
  static const CIRCLEDETAIL = '/circle-detail'; //圈子详情
  static const CIRCLMSG = '/circle-msg'; //圈子消息中心
  static const CIRCLPUBLISH = '/circle-publish'; //发布圈子
  static const CIRCLTOPICLIST = '/circle-topic-list'; //话题圈子列表
  static const SINGLECIRCLELIST = '/single-circle-list'; //单个用户圈子列表
  static const REPORTKNOW = '/report-know'; //举报须知
  static const REPORT = '/report'; //举报
  static const TOPICLIST = '/topic-list'; //话题列表
  //车控
  static const DOORLOCK = '/door-lock-page';//门锁详情
  static const AIRCONDITION = '/air-condition-page';//空调详情
  static const VITUALCONTROL = '/vitual-control-page';//虚拟体验
}
