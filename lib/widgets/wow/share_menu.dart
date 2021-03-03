import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:ws_app_flutter/global/cache_key.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class ShareMenuWidget extends StatelessWidget {
  final bool isCircle; //是否是分享圈子
  final bool showWeibo; //是否隐藏微博
  final String shareType;//分享类型
  final Map<String, dynamic> shareData; //待分享的数据
  final Map<String, dynamic> extraData; //易观统计所需数据
  ShareMenuWidget(
      {this.isCircle = false,
      this.showWeibo = true,
      this.shareType,
      this.shareData,
      this.extraData});

  @override
  Widget build(BuildContext context) {
    var data = [
      {"image": "assets/images/wow/wd_pengyouquan.png", "title": "朋友圈"},
      {"image": "assets/images/wow/wd_weixin.png", "title": "微信"},
    ];
    if (showWeibo) {
      data.add({"image": "assets/images/wow/wd_weibo.png", "title": "微博"});
    }
    if (isCircle && GetPlatform.isIOS) {
      data.add({"image": "assets/images/wow/circle_report.png", "title": "举报"});
    }
    return Container(
      width: double.infinity,
      height: 150,
      color: Color(0xFFECECEC),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomButton(
                  backgroundColor: Colors.transparent,
                  width: Get.width / data.length,
                  height: 66,
                  title: data[index]['title'],
                  fontSize: 12,
                  image: data[index]['image'],
                  imageW: 47,
                  imageH: 47,
                  imagePosition: XJImagePosition.XJImagePositionTop,
                  onPressed: () => shareWithData(index),
                );
              },
              itemCount: data.length,
            ),
          ),
          CustomButton(
            height: 44,
            title: '取消',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future shareWithData(int index) async {
    Get.back();
    ShareSDKPlatform platform;
    String share_method;
    SSDKMap params;
    String urlStr = shareData['url'];
    if (!urlStr.contains('http')) {
      urlStr = CacheKey.SERVICE_URL_HOST + 'htmlrouter/dist' + urlStr;
    }
    if (index == 0) {
      platform = ShareSDKPlatforms.wechatTimeline;
      share_method = '微信朋友圈';
    } else if (index == 1) {
      platform = ShareSDKPlatforms.wechatSession;
      share_method = '微信好友';
    } else if (index == 2) {
      platform = ShareSDKPlatforms.sina;
      share_method = '微博';
    }

    if (platform == ShareSDKPlatforms.sina) {
      params = SSDKMap()
        ..setSina(
          shareData["desc"],
          shareData["title"],
          [shareData["icon"]],
          null,
          null,
          0,
          0,
          null,
          false,
          urlStr,
          null,
          SSDKContentTypes.webpage,
        );
    } else if (platform == ShareSDKPlatforms.wechatTimeline ||
        platform == ShareSDKPlatforms.wechatSession) {
      params = SSDKMap()
        ..setWechat(
            shareData["desc"],
            shareData["title"],
            urlStr,
            shareData["thumbImage"],
            null,
            null,
            null,
            shareData["icon"],
            null,
            null,
            null,
            null,
            null,
            SSDKContentTypes.auto,
            platform);
    }
    SharesdkPlugin.share(platform, params, (SSDKResponseState state,
        Map userdata, Map contentEntity, SSDKError error) {
      if (state == SSDKResponseState.Success) {
        //分享成功
      } else if (state == SSDKResponseState.Fail) {
        Get.dialog(
            BaseDialog(
              title: '分享失败',
              hiddenCancel: true,
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(error.code.toString(),
                    style: TextStyle(fontSize: 16.0)),
              ),
            ),
            barrierDismissible: false);
      } else if (state == SSDKResponseState.Cancel) {
        Get.dialog(
            BaseDialog(
              title: '分享取消',
              hiddenCancel: true,
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('用户取消了分享', style: TextStyle(fontSize: 16.0)),
              ),
            ),
            barrierDismissible: false);
      }
    });
  }
}
