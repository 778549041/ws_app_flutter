import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ws_app_flutter/utils/permission/permission_manager.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";

class ScanPage extends StatefulWidget {
  @override
  ScanPageState createState() => ScanPageState();
}

class ScanPageState extends State<ScanPage> {
  final GlobalKey<QrcodeReaderViewState> qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('扫码'),
      ),
      body: QrcodeReaderView(
        key: qrKey,
        onScan: onScan,
      ),
    );
  }

  Future onScan(String data) async {
    if (data == null) {
      Fluttertoast.showToast(msg: '未扫描到结果');
      return;
    }
  }

  void _requestPermission() async {
    await PermissionManager().requestPermission(Permission.photos);
  }

  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(ScanPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
