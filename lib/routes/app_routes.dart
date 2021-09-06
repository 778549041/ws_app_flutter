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
  static const SIGNPAGE = '/sign-page'; //签到
  static const NORMALQUESTIONPAGE = '/normal-question-page'; //常见问题
  static const INTERAMSGPAGE = '/intera-msg-page'; //互动消息
  static const SYSTEMMSGPAGE = '/system-msg-page'; //系统消息
  static const CERTIFYINFOPAGE = '/certify-info-page'; //认证信息页面
  static const CHECKREPORTPAGE = '/check-report-page'; //检查报告
  static const ELWYPAGE = '/elwy-page'; //e路无忧
  static const ELWYDETAIL = '/elwy-detail';//e路无忧详情
  static const ELWYEXCHANGELIST = '/elwy-exchange';//e路无忧兑换列表
  static const ELWYINTROPAGE = '/elwy-intro';//e路无忧简介
  static const ELWYEXCHANGEDETAIL = '/elwy-exchange-detail';//e路无忧兑换详情
  static const WINLISTRECORD = '/winlist-page'; //中奖纪录
  static const ORDERLISTROUTE = '/orderlist-page'; //兑换订单
  static const ORDERDETAILPAGE = '/order-detail-page'; //订单详情
  static const MYFAVORPAGE = '/my-favor-page';//我的收藏
  static const MYACTIVITYPAGE = '/my-activity-page';//我的活动
  static const INTEGRALPAGE = '/integral-page';//积分页面
  static const INTEGRALRULE = '/integral-rule';//积分规则
  static const INTEGRALSTRATEGY = '/integral-strategy';//积分攻略
  static const CHECKREPORTDETAIL = '/check-report-detail';//检查报告详情

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
  //爱车、车控
  static const DOORLOCK = '/door-lock-page'; //门锁详情
  static const AIRCONDITION = '/air-condition-page'; //空调详情
  static const VITUALCONTROL = '/vitual-control-page'; //虚拟体验
  static const CARPARTS = '/car-parts';//爱车配件
  //优享
  static const GALLERYMALL = '/gallery-mall';//积分商城
  static const PRODUCTDETAIL = '/product-detail';//商品详情
  static const EXCHANGEPRODUCT = '/product-exchange';//商品兑换
}
