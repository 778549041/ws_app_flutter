import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/models/mine/shop_list_model.dart';
import 'package:ws_app_flutter/view_models/mine/shop_list_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';

class ShopAddressListPage extends GetView<ShopListController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '我的收货地址',
      child: CustomScrollView(
        slivers: [
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  ShopAddressModel _item = controller.list[index];
                  return _buildItem(_item);
                }, childCount: controller.list.length),
              )),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: CustomButton(
                backgroundColor: Color(0xFF1C7AF4),
                width: 140,
                height: 40,
                title: '添加地址',
                titleColor: Colors.white,
                radius: 20,
                onPressed: () => controller.editAction(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(ShopAddressModel model) {
    var _address = model.area;
    if (_address.contains('mainland')) {
      _address = _address.split(':')[1];
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/mine/mine_shop_addre_addr.png',
                width: 24,
                height: 29,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            model.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.mobile.replaceFirst(RegExp(r'\d{4}'), '****', 3),
                          style:
                              TextStyle(color: Color(0xFFADADAD), fontSize: 15),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Offstage(
                          offstage: !model.isDefault,
                          child: Image.asset(
                            'assets/images/mine/mine_shop_addre_default.png',
                            width: 32,
                            height: 16,
                          ),
                        )
                      ],
                    ),
                    Text(
                      _address + ' ' + model.addr,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: <Widget>[
                  CustomButton(
                    width: 30,
                    height: 30,
                    image: 'assets/images/mine/mine_shop_addre_edit.png',
                    imageW: 21.5,
                    imageH: 20.5,
                    onPressed: () => controller.editAction(model: model),
                  ),
                  CustomButton(
                    width: 30,
                    height: 30,
                    image: 'assets/images/mine/mine_shop_addre_delete.png',
                    imageW: 21.5,
                    imageH: 23.5,
                    onPressed: () => controller.deleteAction(model),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Color(0xFFD6D6D6),
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
