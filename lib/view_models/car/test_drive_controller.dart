import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/login/address_model.dart';
import 'package:ws_app_flutter/models/login/store_model.dart';
import 'package:ws_app_flutter/utils/net_utils/api.dart';
import 'package:ws_app_flutter/utils/net_utils/dio_manager.dart';
import 'package:ws_app_flutter/view_models/base/base_controller.dart';

class TestDriveController extends BaseController {
  List<AddressModel> provincedata = [];
  List<AddressModel> citydata = [];
  List<StoreModel> storedata = [];
  String? name,
      phone,
      drive,
      province,
      city,
      dealer,
      province1,
      city1,
      dealer1,
      plantime,
      preferred,
      confirm,
      member_id,
      buy_type,
      is_honda,
      area_addr;

  @override
  void onInit() {
    super.onInit();
    getProvinceData();
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
        DioManager.POST, Api.certifyFillFormStoreUrl,
        params: {'city': ccity});
    storedata.clear();
    storedata.addAll(_model.list!);
    if (storedata.length == 0) {
      storedata.add(StoreModel(fAppID: '0', fAdminShopName: '暂无特约店'));
    }
  }

  void inputAction(int index, String value) {
    if (index == 0) {
      //姓名

    } else if (index == 1) {
      //手机号

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
      if (province == null) {
        EasyLoading.showToast('请先选择省份',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      citydata.forEach((element) {
        datas.add(element.cityName!);
      });
    } else if (index == 2) {
      //特约店
      if (city == null) {
        EasyLoading.showToast('请先选择城市',
            toastPosition: EasyLoadingToastPosition.bottom);
        return;
      }
      storedata.forEach((element) {
        datas.add(element.FShopName!);
      });
    } else if (index == 2) {
      //时间
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
            if (address.provinceName == data) {
              await getCityData(provinceid: address.provinceCode);
              if (citydata.length > 0) {
                city = citydata.first.cityName;
                await getStoreData(citydata.first.cityName);
              }
              // store = '请选择特约店';
              // storeid = '';
              // initData();
            }
          }
        } else if (index == 1) {
          //选择城市
          city = data;
          for (var address in citydata) {
            if (address.cityName == data) {
              await getStoreData(address.cityName);
              // store = '请选择特约店';
              // storeid = '';
              // initData();
            }
          }
        } else if (index == 2) {
          //选择特约店
          if (data == '暂无特约店') {
            return;
          }
          // store = data;
          // initData();
          for (var storeitem in storedata) {
            if (storeitem.fAdminShopName == data) {
              // storeid = storeitem.fAppID;
            }
          }
        } else if (index == 2) {
          //选择时间
        }
      },
    );
  }

  void selectRadio(int index, int? value) {
    if (index == 0) {
      //购车情况

    } else if (index == 1) {
      //是否车主

    } else if (index == 2) {
      //试驾时间

    } else if (index == 3) {
      //购车时间

    }
  }

  void checkboxChanged(bool? value) {}

  void submitAction() {}
}
