class Api {
  //此处定义接口名称
  ///登录相关
//未登录海报
  static final unLoginPosterUrl = 'index.php/m/guide.html';
//登录页面背景图片
  static final loginBgDataUrl = 'index.php/m/packageimg-login_image.html';
//登录发送验证码
  static final loginSendCodeUrl = 'm/passport-send_vcode_sms-activation.html';
//登录接口
  static final loginUrl = 'm/passport-post_login.html';
//绑定手机号发送验证码
  static final bindPhoneSendCodeUrl = 'm/passport-send_vcode_sms-signup.html';
//绑定手机号
  static final bindPhoneUrl =
      'index.php/openapi/toauth/callback/wechat_toauth_pam/bind_mobile';
//苹果登录绑定手机号
  static final appleBindPhoneUrl = 'index.php/m/ios-app_bind.html';
//极光推送信息上传
  static final jPushInfoUploadUrl = 'index.php/m/mileage-addregistration.html';
//获取用户IM信息
  static final userIMInfoUrl = 'm/friends-getImUserSig.html';
//检查版本更新
  static final checkNewVersionUrl = 'openapi/hybirdappsetting/edition';
//广告图片数据
  static final aDImageDataUrl = 'openapi/hybirdappsetting/ios';

  /// WOW
//点击e路无忧跳转前判断接口（是否购买过)
  static final ePushJudgeUrl = 'index.php/m/my-is_buy.html';
//商城下订地址接口
  static final mallReservationOrderUrl = 'index.php/m/HP-shopregister.html';
//是否展示e路无忧新手指引状态
  static final shouldShowEGuideSrarusUrl = 'm/my-get_status.html';
//电量信息数据
  static final vechileEleDataUrl = 'wsapp/userMileage/realTimeVehicleStatus';
//首页banner图
  static final homeImageBannerDataUrl = 'm/home.html';
//首页文本banner
  static final homeTextBannerDataUrl = 'index.php/m/packageimg-notice.html';
//首页推荐圈子
  static final homeCircleDataUrl = 'index.php/m/circle-recommend.html';
//首页推荐资讯
  static final homeRecommendNewsUrl = 'm/info-recommend.html';
//首页推荐活动
  static final homeRecommendActivityUrl = 'index.php/m/huodong-act.html';
//首页自定义弹窗
  static final homeCustomToastUrl = 'index.php/m/mileage-advertising.html';
//资讯热门资讯列表数据
  static final newsHotListUrl = 'm/info-hot_recommend.html';
//资讯分类
  static final newsCategoryUrl = 'm/info-column.html';
//资讯列表
  static final newsListDataUrl = 'index.php/m/info-art_list.html';
//资讯详情
  static final newsDetailUrl = 'index.php/m/info-art_detail.html';
//分享送积分
  static final shareSendPointUrl = 'index.php/m/circle-counselShare.html';
//资讯详情评论列表
  static final newsDetailCommentListUrl = 'index.php/m/info-cmt_list.html';
//资讯详情取消收藏
  static final newsDetailUnFavorUrl =
      'index.php/m/info-delete_art_collect.html';
//资讯详情收藏
  static final newsDetailFavorUrl = 'index.php/m/info-art_collect.html';
//资讯详情文章取消点赞
  static final newsDetailUnPraiseUrl = 'index.php/m/info-delete_praise.html';
//资讯详情文章点赞
  static final newsDetailPraiseUrl = 'index.php/m/info-art_praise.html';
//资讯详情评论取消点赞
  static final newsDetailCommentUnPraiseUrl =
      'index.php/m/info-delete_cmt_praise.html';
//资讯详情评论点赞
  static final newsDetailCommentPraiseUrl = 'index.php/m/info-cmt_praise.html';
//资讯详情评论删除（仅能删除自己的）
  static final newsDetailDeleteCommentUrl = 'index.php/m/info-delete_cmt.html';
//资讯详情添加评论
  static final newsDetailAddCommentUrl = 'index.php/m/info-add_cmt.html';
//充电站列表
  static final mapCDZListUrl = 'm/charging.html';
//特约店列表数据
  static final mapCDZStoreListUrl = 'index.php/m/charging-mapshop.html';
//单个充电站信息
  static final mapSingleCDZUrl = 'm/charging-stationinfo.html';
//充电站下的所有充电桩列表
  static final mapAllCDZhanListUrl = 'm/charging-connector_list.html';
//资讯搜索tag标签
  static final newsSearchTagUrl = 'm/info-tag_list.html';
//资讯根据输入内容搜索
  static final newsSearchWithKeyUrl = 'm/info-search.html';
//资讯根据tag搜索
  static final newsSearchWithTagUrl = 'm/info-tag_search.html';

  /// 圈子
//圈子动态列表
  static final circleMomentListUrl = 'index.php/m/circle.html';
//圈子推荐好友
  static final circleRecommendFriendsUrl = 'index.php/m/circle-f_recommen.html';
//圈子动态取消点赞
  static final circleMomentUnPraiseUrl =
      'index.php/m/circle-del_circle_praise.html';
//圈子动态点赞
  static final circleMomentPraiseUrl = 'index.php/m/circle-cricle_praise.html';
//圈子动态评论取消点赞
  static final circleMomentCommentUnPraiseUrl =
      'index.php/m/circomment-delete_cmt_praise.html';
//圈子动态评论点赞
  static final circleMomentCommentPraiseUrl =
      'index.php/m/circomment-cmt_praise.html';
//圈子详情
  static final circleMomentDetailUrl = 'index.php/m/circle-circle.html';
//圈子详情评论列表
  static final circleMomentDetailCommentListUrl =
      'index.php/m/circomment-comment_list.html';
//圈子详情删除评论（仅能删除自己的）
  static final circleMomentDetailDeleteCommentUrl =
      'index.php/m/circomment-delete_cmt.html';
//圈子列表删除圈子（仅能删除自己的）
  static final circleDeleteMomentUrl = 'index.php/m/circle-del_circle.html';
//圈子详情评论添加回复评论
  static final circleMomentDetailAddReplyForCommentUrl =
      'index.php/m/circomment-add_cmt.html';
//圈子校验发布内容敏感词
  static final circlePublishContentValidateUrl =
      'index.php/m/circomment-special_word.html';
//圈子发布动态
  static final circlePublishMomentUrl = 'index.php/m/circle-add.html';
//圈子添加好友
  static final circleAddFriendUrl = 'm/friends-addFriend.html';
//圈子我的好友列表
  static final circleMyFriendsListUrl = 'm/friends-friends.html';
//圈子我的好友搜索
  static final circleMyFriendsSearchUrl = 'm/friends-friends.html';
//圈子添加好友推荐好友
  static final circleAddFriendRecommendListUrl = 'm/circle-f_recommen.html';
//圈子添加好友搜索
  static final circleAddFriendSearchUrl = 'm/circle-f_search.html';
//圈子发布动态图片和视频id转url
  static final convertIDToUrl = 'index.php/m/circle-upload.html';
//话题列表
  static final circleTopicListUrl = 'index.php/m/topicV1-lists.html';
  //话题列表（发布动态时选择话题）
  static final publishSelectTopicListUrl =
      'index.php/m/circleTopicV1v1-tagTopic.html';
  //我的话题列表(我自己是主理人)
  static final circleMyTopicListUrl = 'index.php/m/circleTopicV1v1-mine.html';
  //我的话题，申请列表
  static final myTopicApplyListUrl = 'index.php/m/circleTopicV1v1-apply.html';
  //我关注的话题列表
  static final mineFollowTopicListUrl =
      'index.php/m/circleTopicV1v1-myFollow.html';
  //取消关注话题
  static final cancelFocusOnTopicUrl =
      'index.php/m/circleTopicV1v1-cancelFollow.html';
  //申请加入话题
  static final applyJoinTopicUrl = 'index.php/m/circleTopicV1v1-join.html';
  //关注话题
  static final focusOnTopicUrl = 'index.php/m/circleTopicV1v1-follow.html';
  //创建话题
  static final createTopicUrl = 'm/circleTopicV1v1-add.html';
  //设置话题权限
  static final settingTopicPermissionUrl =
      'index.php/m/circleTopicV1v1-setAccess.html';
  //申请加入话题纪录
  static final applyJoinTopicListUrl =
      'index.php/m/circleTopicV1v1-joinUser.html';
  //话题加入申请审核
  static final applyJoinTopicReviewUrl =
      'index.php/m/circleExamineV1v1-join.html';
  //话题详情
  static final circleTopicDetailUrl = 'index.php/m/circleTopicV1v1-info.html';
  //好友详情圈子数据
  static final circleFriendsMomentUrl = 'index.php/m/circle-pic_list.html';
  //更多热门榜列表
  static final circleHotListUrl = 'index.php/m/hotsV1-hots_list.html';
  //圈子动态审核列表
  static final momentReviewListUrl =
      'index.php/m/circleTopicV1v1-indexExamine.html';
  //评论审核列表
  static final commentReviewListUrl =
      'index.php/m/circleTopicV1v1-commentExamine.html';
  //动态内容审核
  static final reviewMomentUrl = 'index.php/m/circleExamineV1v1-indexs.html';
  //评论内容审核
  static final reviewCommentUrl = 'index.php/m/circleExamineV1v1-comment.html';
  //圈子加优质
  static final setMomentGood = 'index.php/m/circleIndexV1v1-setGood.html';
  //圈子取消加优质
  static final cancelMomentGood = 'index.php/m/circleIndexV1v1-cancelGood.html';
  //圈子置顶
  static final setMomentTop = 'index.php/m/circleIndexV1v1-setTop.html';
  //圈子取消置顶
  static final cancelMomentTop = 'index.php/m/circleIndexV1v1-cancelTop.html';

  //圈子二期
  //圈子首页热门推荐
  static final circleHotRecommendUrl = 'index.php/m/hotsV2-hots_recommend.html';
  //圈子首页官方动态
  static final circleOfficialMomenttUrl = 'index.php/m/topicV1-official.html';
  //用户圈子标签
  static final userCircleTagUrl = 'index.php/m/circleTagV1v1-user.html';
  //圈子所有标签
  static final circleTagListUrl = 'index.php/m/circleTagV1v1.html';
  //圈子所有标签
  static final allCircleTagListUrl = 'index.php/m/circleTagV1v1.html';
  //保存用户圈子标签
  static final saveUsersTagUrl = 'index.php/m/circleTagV1v1-sort.html';
  //新版圈子列表
  static final newVersionMomentListUrl = 'index.php/m/circleIndexV1v1.html';
  //所有问答标签
  static final allFAQTagsListUrl = 'index.php/m/questionV2-get_type.html';
  //热门回答
  static final hotFAQListUrl = 'index.php/m/questionV2-hots_question.html';
  //随便看看
  static final casuallyFAQListUrl = 'index.php/m/questionV2-casual_look.html';
  //往期热点
  static final pastHotFAQListUrl = 'index.php/m/questionV2-past_hots.html';
  //删除提问
  static final deleteQuestionUrl =
      'index.php/m/questionV2-question_delete.html';
//提问点赞、取消点赞
  static final questionPraiseUrl =
      'index.php/m/questionV2-question_praise.html';
//回答点赞、取消点赞
  static final answerPraiseUrl = 'index.php/m/questionV2-answers_praise.html';
  //问答详情-问题
  static final faqDetailQuestionUrl =
      'index.php/m/questionV2-detail_question.html';
//问答详情-回答
  static final faqDetailAnswerListUrl =
      'index.php/m/questionV2-detail_answers.html';
//删除回答
  static final deleteAnswerUrl = 'index.php/m/questionV2-answers_delete.html';
//采纳回答
  static final acceptAnswerUrl = 'index.php/m/questionV2-answers_accept.html';
  //发布提问
  static final publishQuestionUrl = 'index.php/m/questionV2-question_add.html';
  //我的提问
  static final mineQuestionListUrl = 'index.php/m/questionV2-my_question.html';
//我的回答
  static final mineAnswerListUrl = 'index.php/m/questionV2-my_answers.html';

  /// 优享
//优享抽大奖地址
  static final enjoyCDJUrl = 'm/home-activity.html';
//优享许心愿
  static final enjoyXXYUrl = 'index.php/m/wish-wish_verify.html';
//优享服务套餐KV图片
  static final enjoyFWTCKVImageUrl = 'index.php/m/packageimg.html';
//优享积分商城商品列表
  static final enjoyMallListUrl = 'm/integralmall.html';

  /// 爱车
//预约保养地址接口
  static final reservationMaintainUrl = 'wsapp/userauth/reservation';
//爱车非车主附近特约店
  static final carNearByStoreUrl = 'index.php/m/charging-nearby.html';
//爱车车辆配置信息
  static final carConfigUrl = 'm/packageimg-car.html';
  //违章查询
  static final violationQueryUrl = 'm/violations-query.html';
  //预约试驾省份、城市
  static final orderTestDriveProvinceUrl = 'm/drive-region.html';
  //预约试驾特约店
  static final orderTestDriveShopUrl = 'm/drive-shops.html';
  //预约试驾检查当前选择特约店是否可以试驾
  static final orderTestDriveCanPerformUrl = 'm/drive-check_dealer.html';
  //预约试驾提交申请
  static final orderTestDriveSubmitUrl = 'm/drive-add_drive.html';
  //里程信息
  static final mileageListUrl = 'm/mileage.html';
  //领取积分
  static final acceptPointsUrl = 'm/circle-mileage_score.html';
  //电池诊断
  static final batteryCheckUrl = 'wsapp/ownerReport/getReport';

  /// 我的
//用户信息
  static final userInfoUrl = 'm/aesmy.html';
//修改用户信息
  static final changeUserInfoUrl = 'm/my-save_setting.html';
//退出登录
  static final logoutUrl = 'm/passport-logout.html';
//用户积分和活动数量
  static final userPointAndOtherDataUrl = 'm/my-score.html';
//清除未读消息
  static final clearUnReadMessageUrl = 'index.php/m/news-readmessage.html';
//虚拟车主解绑
  static final unbindVechileUrl = 'm/mileage-delvirtual.html';
//我的新消息接口
  static final mineNewMessageUrl = 'm/my-unMessageCount.html';
//我的收藏、活动数据
  static final mineFavorActivityUrl = 'index.php/m/circle-my_record.html';
//修改密码发送验证码
  static final changedPwdSendCodeUrl = 'm/passport-member_vcode.html';
//修改密码
  static final changedPwdSubmitUrl = 'm/passport-reset_password-doreset.html';
//修改积分支付密码验证身份发送验证码
  static final changedServicePwdAuthSendCodeUrl =
      'm/passport-send_vcode_sms.html';
//修改积分支付密码验证身份
  static final changedServicePwdAuthSubmitUrl = 'm/my-verify.html';
//修改积分支付密码
  static final changedServicePwdUrl = 'm/my-save_password.html';
//修改绑定手机号发送验证码
  static final changedBindPhoneSendCodeUrl =
      'm/passport-send_vcode_sms-bindmobile.html';
//解除绑定手机号
  static final unbindPhoneUrl = 'm/my-uset_pam_mobile.html';
//绑定新手机号
  static final bindNewPhoneUrl = 'm/my-set_pam_mobile-save.html';
//兴趣爱好列表
  static final intrestListUrl = 'm/home-interest_list.html';
//设置兴趣爱好
  static final changedIntrestUrl = 'm/home-dointerest.html';
//我的收获地址列表
  static final mineTakeGoodsAddressListUrl = 'm/my-receiver.html';
//修改、新增收货地址
  static final changedTakeGoodsAddressUrl = 'm/my-receiver-save.html';
//我的意见反馈
  static final mineFeedBackUrl = 'm/feedback-save.html';
//微信授权登录、认证
  static final wechatAuthLoginOrCertifyUrl =
      'index.php/openapi/toauth/callback/wechat_toauth_pam/callback';
//苹果登录
  static final appleLoginUrl = 'index.php/m/ios-login.html';
//救援、客服电话
  static final servicePhoneUrl = 'm/telephone.html';
  //是否已签到信息
  static final signDataUrl = 'm/integralsignin.html';
  //签到操作
  static final signEventUrl = 'm/integralsignin-signin.html';
  //常见问题
  static final normalQuestionUrl = 'm/answering.html';
  //检查报告
  static final reportListUrl = 'm/thirdparty-condition_list.html';
  //检查报告详情
  static final reportDetailUrl = 'm/thirdparty-condition_detail.html';
  //我的e路无忧
  static final myPackagesListUrl = 'm/my-packages.html';
  //e路无忧详情
  static final packagesDetailUrl = 'm/my-package_detail.html';
  //e路无忧套餐兑换列表
  static final packagesExchangeListUrl = 'm/package-goods_list.html';
  //e路无忧套餐兑换详情
  static final packagesExchangeDetailUrl = 'm/package-goods_detail.html';
  //我的收藏
  static final myFavorUrl = 'm/info-collection_list.html';
  //取消收藏
  static final cancelFavorUrl = 'm/info-delete_art_collect.html';
  //绑定车控车辆
  static final bindCarUrl = '/m/vehiclecontrol-bind.html';
  //绑定车控车辆信息
  static final carInfoUrl = '/m/vehiclecontrol-bind_info.html';
  //解绑车辆发送验证码
  static final unbindCarSendCodeUrl = '/m/vehiclecontrol-send_sms_code.html';
  //解绑车辆
  static final unbindCarUrl = '/m/vehiclecontrol-unbind.html';

  /// 活动相关
//扫描活动二维码
  static final activityScanUrl = 'index.php/m/wsparty-active.html';
//签到二维码
  static final scanSignUrl = 'index.php/m/wsparty-sign.html';
//媒体试驾绑定虚拟车主
  static final scanMediaTestDriveVechileUrl =
      'index.php/m/mediarun-bindvin.html';
//媒体试驾扫描二维码送积分
  static final scanMediaTestDrivePointUrl =
      'index.php/m/mediarun-givescore.html';

  /// 车主认证
//车主认证
  static final certifyVechileUrl = 'm/my-auther_car.html';
//车主留资认证token
  static final certifyFillFormTokenUrl = 'm/mileage-member_token.html';
//车主留资认证获取省份城市
  static final certifyFillFormProvinceUrl = 'm/mileage-authcity.html';
//车主留资认证获取特约店数据
  static final certifyFillFormStoreUrl = 'm/mileage-authshops.html';
//车主留资认证提交表单
  static final certifyFillFormSubmitUrl = 'm/mileage-authvin.html';
//车主申诉提交意见
  static final certifyFeedBackUrl = 'm/feedback-add.html';
//车主认证信息
  static final vechileInfoUrl = 'wsapp/userauth/carInfo';

  /// DMP统计
//上传DMP统计数据
  static final uploadDMPDataUrl = 'index.php/m/thirdparty-monitor.html';
//上传分享统计数据
  static final uploadShareDataUrl = 'index.php/m/share-add.html';
}
