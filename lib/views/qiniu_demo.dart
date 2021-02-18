import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qiniu/flutter_qiniu.dart';
import 'package:flutter_qiniu/flutter_qiniu_config.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert' as convert;

class QiNiuDemoPage extends StatefulWidget {
  @override
  QiNiuDemoPageState createState() => QiNiuDemoPageState();
}

class QiNiuDemoPageState extends State<QiNiuDemoPage> {
  File _image;
  String _filePath;
  final picker = ImagePicker();
  String _uploadResultString = '';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      print('图片地址:${pickedFile.path}');
      _filePath = pickedFile.path;
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: ${FlutterQiNiu.platformVersion}\n'),
              FlatButton(
                child: Text('选择图片'),
                onPressed: () {
                  getImage();
                },
              ),
              Container(
                height: 300,
                width: 300,
                child: _image == null ? Text('No image selected.') : Image.file(
                    _image),
              ),
              FlatButton(
                child: Text('上传图片'),
                onPressed: () async {
                  FlutterQiNiuConfig config = FlutterQiNiuConfig(
                      token: 'fG4R4vdljfy24rzGLro27S51VFLsCEO7WZay23fM:PNJ2JqCrkDG4TBNSCYkPNLPQrE0=:eyJkZWFkbGluZSI6MTU5NjU0NDM3NCwibWltZUxpbWl0IjoiaW1hZ2UvKiIsInJldHVybkJvZHkiOiJ7XCJiYXNlX3VybFwiOlwiaHR0cDovL2F2YXRhci54aWFveGlucWluZy5jb20vXCIsIFwia2V5XCI6ICQoa2V5KSwgXCJ3aWR0aFwiOiAkKGltYWdlSW5mby53aWR0aCksIFwiaGVpZ2h0XCI6ICQoaW1hZ2VJbmZvLmhlaWdodCl9Iiwic2F2ZUtleSI6IiQoZXRhZykkKGV4dCkiLCJzY29wZSI6InhpYW94aW5xaW5nLWF2YXRhciJ9',
                      filePath: _filePath);
                  var result = await FlutterQiNiu.upload(config,(key,percent){
                    print('---上传进度:$key--$percent--------');
                  });

                  print('flutter 结果:$result');

                  _uploadResultString = convert.jsonEncode(result);

                  setState(() {

                  });

                },
              ),
              Text(_uploadResultString),

            ],
          ),
        ),
      );
  }
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  void didUpdateWidget(QiNiuDemoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}