import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/address_model.dart';
import 'package:ws_app_flutter/models/login/store_model.dart';
import 'package:ws_app_flutter/routes/app_pages.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class CertifyController extends GetxController {
  var data = [].obs;
  List<AddressModel> provincedata = [];
  List<AddressModel> citydata = [];
  List<StoreModel> storedata = [];
  String? province, city, store, storeid, name, vincode;

  @override
  void onInit() {
    province = '请选择省份';
    city = '请选择城市';
    store = '请选择特约店';
    storeid = '';
    name = '';
    vincode = '';
    initData();
    getCertifyToken();
    getProvinceData();
    super.onInit();
  }

  void initData() {
    data.assignAll([
      {'title': '省   份', 'content': province, 'placeholder': ''},
      {'title': '城   市', 'content': city, 'placeholder': ''},
      {'title': '特约店', 'content': store, 'placeholder': ''},
      {'title': '姓   名', 'content': name, 'placeholder': '请输入你的姓名'},
      {'title': '车架号', 'content': vincode, 'placeholder': '请输入17位车架号'},
    ]);
  }

  //token校验
  Future getCertifyToken() async {
    await DioManager().request(DioManager.GET, Api.certifyFillFormTokenUrl);
  }

  //获取省份数据
  Future getProvinceData() async {
    AddressListModel _model = await DioManager().request<AddressListModel>(
        DioManager.POST, Api.certifyFillFormProvinceUrl,
        params: {'province': '1'});
    provincedata.addAll(_model.list!);
  }

  //获取城市数据
  Future getCityData({String? cityid}) async {
    AddressListModel _model = await DioManager().request<AddressListModel>(
        DioManager.POST, Api.certifyFillFormProvinceUrl,
        params: {'city': cityid});
    citydata.clear();
    citydata.addAll(_model.list!);
  }

  //获取特约店数据
  Future getStoreData(String? cityid) async {
    StoreListModel _model = await DioManager().request<StoreListModel>(
        DioManager.POST, Api.certifyFillFormStoreUrl,
        params: {'shop': cityid});
    storedata.clear();
    storedata.addAll(_model.list!);
    if (storedata.length == 0) {
      storedata.add(StoreModel(fAppID: '0', fAdminShopName: '暂无特约店'));
    }
  }

  //选择
  void selectData(int index) {
    List<String> datas = [];
    if (index == 0) {
      provincedata.forEach((element) {
        datas.add(element.fName!);
      });
    } else if (index == 1) {
      if (province == null) {
        EasyLoading.showToast('请先选择省份',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      citydata.forEach((element) {
        datas.add(element.fName!);
      });
    } else if (index == 2) {
      if (city == null) {
        EasyLoading.showToast('请先选择城市',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      storedata.forEach((element) {
        datas.add(element.fAdminShopName!);
      });
    }

    Pickers.showSinglePicker(
      Get.context!,
      data: datas,
      pickerStyle: DefaultPickerStyle(),
      onConfirm: (data, position) async {
        if (index == 0) {
          //选择省份
          province = data;
          for (var address in provincedata) {
            if (address.fName == data) {
              await getCityData(cityid: address.fItemId);
              if (citydata.length > 0) {
                city = citydata.first.fName;
                await getStoreData(citydata.first.fItemId);
              }
              store = '请选择特约店';
              storeid = '';
              initData();
            }
          }
        } else if (index == 1) {
          //选择城市
          city = data;
          for (var address in citydata) {
            if (address.fName == data) {
              await getStoreData(address.fItemId);
              store = '请选择特约店';
              storeid = '';
              initData();
            }
          }
        } else if (index == 2) {
          //选择特约店
          if (data == '暂无特约店') {
            return;
          }
          store = data;
          initData();
          for (var storeitem in storedata) {
            if (storeitem.fAdminShopName == data) {
              storeid = storeitem.fAppID;
            }
          }
        }
      },
    );
  }

  //输入
  void inputAction(int index, String value) {
    if (index == 3) {
      name = value;
    } else if (index == 4) {
      vincode = value;
    }
    initData();
  }

  //提交资料
  Future submitAction() async {
    if (province == null) {
      EasyLoading.showToast('请选择省份',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (city == null) {
      EasyLoading.showToast('请选择城市',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (store == null) {
      EasyLoading.showToast('请选择特约店地址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (name == null) {
      EasyLoading.showToast('请输入你的姓名',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (vincode == null || vincode!.length != 17) {
      EasyLoading.showToast('您输入的车架号长度有误，请输入17位VE-1车架号哦！',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel _model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.certifyFillFormSubmitUrl,
        params: {'appid': storeid, 'vin': vincode, 'username': name});
    if (_model.success != null) {
      // DMPTJManager().uploadManualCertifyData({});
    } else if (_model.error != null) {
      if (_model.redirect == '1001') {
        Get.dialog(
            BaseDialog(
              title: '提示',
              rightText: '申诉',
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(_model.message!, style: TextStyle(fontSize: 16.0)),
              ),
              onConfirm: () {
                Get.toNamed(Routes.COMPLAINT, arguments: {
                  'province': province,
                  'city': city,
                  'store': store,
                  'name': name,
                  'vincode': vincode
                });
              },
            ),
            barrierDismissible: false);
      } else if (_model.error!.contains('href')) {
        Get.dialog(
            BaseDialog(
              title: '认证失败',
              rightText: '确定',
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(_model.message!, style: TextStyle(fontSize: 16.0)),
              ),
              onConfirm: () {
                Get.toNamed(Routes.WEBVIEW,
                    arguments: {'url': 'https://www.ghac.cn/upload'});
              },
            ),
            barrierDismissible: false);
      } else {
        Get.dialog(
            BaseDialog(
              title: '认证失败',
              hiddenCancel: true,
              leftText: '确定',
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(_model.error!, style: TextStyle(fontSize: 16.0)),
              ),
            ),
            barrierDismissible: false);
      }
    }
  }
}
