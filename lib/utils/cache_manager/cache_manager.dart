import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  ///加载缓存
  Future<String> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      LogUtil.d('临时目录大小: ' + value.toString());
      return _renderSize(value);
    } catch (err) {
      LogUtil.d(err);
      return '0';
    }
  }

  /// 递归方式 计算文件的大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      LogUtil.d(e);
      return 0;
    }
  }

  /// 清理缓存
  Future<bool> clearCache() async {
    //此处展示加载loading
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await _delDir(tempDir);
      EasyLoading.showToast('清除缓存成功',
          toastPosition: EasyLoadingToastPosition.bottom);
      return true;
    } catch (e) {
      EasyLoading.showToast('清除缓存失败',
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    } finally {
      //此处隐藏加载loading
    }
  }

  ///递归方式删除目录
  Future _delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await _delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      LogUtil.d(e);
    }
  }

  ///格式化文件大小
  _renderSize(double value) {
    List<String> unitArr = []..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}
