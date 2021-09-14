import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/common/common_model.dart';
import 'package:ws_app_flutter/models/login/address_model.dart';
import 'package:ws_app_flutter/models/login/store_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';
import 'package:ws_app_flutter/view_models/mine/user_controller.dart';
import 'package:ws_app_flutter/widgets/global/custom_dialog.dart';

class TestDriveController extends BaseController {
  List<AddressModel> provincedata = [];
  List<AddressModel> citydata = [];
  List<StoreModel> storedata = [];
  String name = '', //名称
      phone = '', //手机号
      province1 = '', //省份编码
      city1 = '', //城市编码
      dealer1 = '', //特约店编码
      plantime = '7'; //计划购车时间,7是7天，30是一个月内，90是三个月内

  var buy_type = 1.obs; //购车情况，1首购，2增购
  var is_honda = 0.obs; //是否honda车主，0是，1否
  var drive = 1.obs; //希望试驾时间，1是平时，2周末
  var province = ''.obs; //省份
  var city = ''.obs; //城市
  var dealer = ''.obs; //特约店名
  var area_addr = ''.obs; //特约店地址
  var planbuy = 0.obs; //计划购车时间,0是7天，1是一个月内，2是三个月内
  var concattime = ''.obs; //联络时间

  var aggree = false.obs; //是否同意协议

  @override
  void onInit() {
    super.onInit();
    getProvinceData();
  }

  @override
  void onReady() {
    super.onReady();
    if (!Get.find<UserController>().userInfo.value.isLogin!) {
      Get.dialog(
        BaseDialog(
          title: '提示',
          hiddenCancel: true,
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('请先登录', style: TextStyle(fontSize: 16.0)),
          ),
          onConfirm: () {
            Get.close(1);
          },
        ),
        barrierDismissible: false,
      );
    }
  }

  //获取省份数据
  Future getProvinceData() async {
    AddressListModel _model = await DioManager().request<AddressListModel>(
        DioManager.GET, Api.orderTestDriveProvinceUrl);
    provincedata.addAll(_model.list!);
  }

  //获取城市数据
  Future getCityData({String? provinceid}) async {
    AddressListModel _model = await DioManager().request<AddressListModel>(
        DioManager.POST, Api.orderTestDriveProvinceUrl,
        params: {'province': provinceid});
    citydata.clear();
    citydata.addAll(_model.list!);
  }

  //获取特约店数据
  Future getStoreData(String? ccity) async {
    StoreListModel _model = await DioManager().request<StoreListModel>(
        DioManager.POST, Api.orderTestDriveShopUrl,
        params: {'city': ccity});
    storedata.clear();
    storedata.addAll(_model.list!);
    if (storedata.length == 0) {
      storedata.add(StoreModel(fAppID: '0', FShopName: '暂无特约店'));
    }
  }

  void checkStoreCanTestDrive() async {
    CommonModel model = await DioManager().request<CommonModel>(
        DioManager.POST, Api.orderTestDriveCanPerformUrl,
        params: {'dealer_code': dealer1});
    if (model.data?.has_vehicle != null && !model.data!.has_vehicle!) {
      EasyLoading.showToast('当前特约店暂无试驾车辆，请选择其他特约店',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  void inputAction(int index, String value) {
    if (index == 0) {
      //姓名
      name = value;
    } else if (index == 1) {
      //手机号
      phone = value;
    }
  }

  void selectData(int index) {
    List<String> datas = [];
    if (index == 0) {
      //省份
      provincedata.forEach((element) {
        datas.add(element.provinceName!);
      });
    } else if (index == 1) {
      //城市
      if (province.value.length == 0) {
        EasyLoading.showToast('请先选择省份',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      citydata.forEach((element) {
        datas.add(element.cityName!);
      });
    } else if (index == 2) {
      //特约店
      if (city.value.length == 0) {
        EasyLoading.showToast('请先选择城市',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      storedata.forEach((element) {
        datas.add(element.FShopName!);
      });
    } else if (index == 3) {
      //时间
      datas.addAll(['上午(9:00-12:00)', '下午(13:00-18:00)']);
    }

    Pickers.showSinglePicker(
      Get.context!,
      data: datas,
      pickerStyle: DefaultPickerStyle(),
      onConfirm: (data, position) async {
        if (index == 0) {
          //选择省份
          province.value = data;
          for (var address in provincedata) {
            if (address.provinceName == data) {
              await getCityData(provinceid: address.provinceCode);
              if (citydata.length > 0) {
                city.value = citydata.first.cityName!;
                await getStoreData(citydata.first.cityName);
              }
              dealer.value = '';
              dealer1 = '';
            }
          }
        } else if (index == 1) {
          //选择城市
          city.value = data;
          for (var address in citydata) {
            if (address.cityName == data) {
              await getStoreData(address.cityName);
              dealer.value = '';
              dealer1 = '';
            }
          }
        } else if (index == 2) {
          //选择特约店
          if (data == '暂无特约店') {
            return;
          }
          dealer.value = data;
          for (var storeitem in storedata) {
            if (storeitem.FShopName == data) {
              dealer1 = storeitem.fAppID!;
              checkStoreCanTestDrive();
            }
          }
        } else if (index == 3) {
          //选择时间
          concattime.value = data;
        }
      },
    );
  }

  void selectRadio(int index, int? value) {
    if (index == 0) {
      //购车情况
      buy_type.value = value! + 1;
    } else if (index == 1) {
      //是否车主
      is_honda.value = value!;
    } else if (index == 2) {
      //试驾时间
      drive.value = value! + 1;
    } else if (index == 3) {
      //购车时间
      planbuy.value = value!;
      if (value == 0) {
        plantime = '7';
      } else if (value == 1) {
        plantime = '30';
      } else if (value == 2) {
        plantime = '90';
      }
    }
  }

  void checkboxChanged(bool? value) {
    aggree.value = value!;
  }

  void submitAction() async {
    if (name.length == 0) {
      EasyLoading.showToast('请填写姓名',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (phone.length == 0) {
      EasyLoading.showToast('请填写联系方式',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!RegexUtil.isMobileExact(phone)) {
      EasyLoading.showToast('手机号码格式错误',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (dealer.value.length == 0) {
      EasyLoading.showToast('请选择特约店地址',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (concattime.value.length == 0) {
      EasyLoading.showToast('请选择首选联络时间',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (!aggree.value) {
      EasyLoading.showToast('请仔细阅读《用户保护信息及对策声明》',
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    CommonModel model = await DioManager().request<CommonModel>(
      DioManager.POST,
      Api.orderTestDriveSubmitUrl,
      params: {
        'name': name,
        'phone': phone,
        'drive': drive.value,
        'province': province.value,
        'city': city.value,
        'dealer': dealer.value,
        'province1': province1,
        'city1': city1,
        'dealer1': dealer1,
        'plantime': plantime,
        'preferred': 1,
        'confirm': true,
        'member_id':
            Get.find<UserController>().userInfo.value.member!.memberId!,
        'buy_type': buy_type.value,
        'is_honda': is_honda.value == 0 ? 1 : 0,
        'area_addr': area_addr.value,
      },
    );
    if (model.error != null) {
      EasyLoading.showToast(model.error!,
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast('提交成功，请耐心等待工作人员联系您',
          toastPosition: EasyLoadingToastPosition.bottom);
      Future.delayed(Duration(seconds: 1)).then((value) async {
        Get.back();
      });
    }
  }
}
