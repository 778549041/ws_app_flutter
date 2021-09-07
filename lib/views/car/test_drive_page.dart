import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ws_app_flutter/global/color_key.dart';
import 'package:ws_app_flutter/view_models/car/test_drive_controller.dart';
import 'package:ws_app_flutter/views/base_page.dart';
import 'package:ws_app_flutter/widgets/global/custom_button.dart';
import 'package:ws_app_flutter/widgets/global/custom_textfield.dart';
import 'package:ws_app_flutter/widgets/global/form_select_cell.dart';

class TestDrivePage extends GetView<TestDriveController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: '预约试驾',
      bgColor: MainAppColor.mainSilverColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildRichText('为必填项，您的信息我们将会完全保密，请您放心填写。', 12),
            SizedBox(
              height: 10,
            ),
            _buildRichText('真实姓名', 15),
            SizedBox(
              height: 10,
            ),
            _buildTextField(0, '您的真实姓名'),
            SizedBox(
              height: 10,
            ),
            _buildRichText('联系方式', 15),
            SizedBox(
              height: 10,
            ),
            _buildTextField(1, '您的手机号'),
            SizedBox(
              height: 10,
            ),
            _buildRichText('购车情况', 15),
            _buildRadiuRow(0, ['首购', '增购'], 0),
            Offstage(
              offstage: false,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildRichText('是否为广汽Honda车主', 15),
                    _buildRadiuRow(1, ['是', '否'], 0),
                  ],
                ),
              ),
            ),
            Text(
              '希望试驾时间',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            _buildRadiuRow(2, ['平时', '周末'], 0),
            _buildRichText('附近的特约店', 15),
            _buildSelectRow(0, '', '请选择省份'),
            _buildSelectRow(1, '', '请选择城市'),
            _buildSelectRow(2, '', '请选择特约店'),
            Offstage(
              offstage: false,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text('特约店地址：XXXXXXXX'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '计划购车时间',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            _buildRadiuRow(3, ['7天', '1个月内', '3个月内'], 0),
            _buildRichText('首选联络时间', 15),
            _buildSelectRow(3, '', '请选择你的联络时间'),
            Row(
              children: <Widget>[
                Checkbox(
                    value: false,
                    onChanged: (value) => controller.checkboxChanged(value)),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '本人同意',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: '《用户保护信息及对策声明》',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4245E5),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.pushH5Page(args: {
                                  'url': 'https://wsapp.ghac.cn/yszc.html',
                                  'hasNav': true,
                                });
                              }),
                        TextSpan(
                          text: '；广汽本田将对您提交的个人信息保密，不对外公开。',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 20),
              child: Center(
                child: CustomButton(
                  backgroundColor: MainAppColor.mainBlueBgColor,
                  width: 180,
                  height: 40,
                  title: '确定提交',
                  titleColor: Colors.white,
                  radius: 20,
                  onPressed: () => controller.submitAction(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String title, double fontSize) {
    return RichText(
      text: TextSpan(
        text: '*',
        style: TextStyle(color: Color(0xFFFF0000), fontSize: fontSize),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: Colors.black, fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(int index, String placeholder) {
    return CustomTextField(
      hintText: placeholder,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
      ),
      submitCallBack: (value) {},
    );
  }

  Widget _buildRadiuRow(int index, List<String> titles, int groupValue) {
    return Row(
      children: List.generate(titles.length, (index) {
        return Row(
          children: <Widget>[
            Radio(
              value: index,
              onChanged: (int? value) => controller.selectRadio(index, value),
              groupValue: groupValue,
            ),
            Text(titles[index]),
          ],
        );
      }),
    );
  }

  Widget _buildSelectRow(int index, String text, String placeholder) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: MainAppColor.seperatorLineColor, width: 0.5),
      ),
      child: FormSelectCell(
        text: text,
        hintText: placeholder,
        hintTextStyle: TextStyle(fontSize: 15),
        hiddenArrow: true,
        bgColor: Colors.transparent,
        hiddenLine: true,
        rightWidget: Image.asset(
          'assets/images/mine/icon_down_arrow.png',
          width: 10.5,
          height: 19.5,
        ),
        clickCallBack: () {},
      ),
    );
  }
}
