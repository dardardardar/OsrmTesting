import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osrmtesting/core/utils/device.dart';
import 'package:path_provider/path_provider.dart';

Future<File> copyAssetToFile(String assetFile) async {
  final tempDir = await getTemporaryDirectory();
  final filename = assetFile.split('/').last;
  final file = File('${tempDir.path}/$filename');

  final data = await rootBundle.load(assetFile);
  await file.writeAsBytes(
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
    flush: true,
  );
  return file;
}

double sizeByScreenWidth(
    {required BuildContext context, required double sizePercent}) {
  if (sizePercent > 1 || sizePercent <= 0) {
    return MediaQuery.of(context).size.width;
  }
  return MediaQuery.of(context).size.width * sizePercent;
}

Future<String> getUserAgent() async {
  Info info = await DeviceInfo().getInfo();
  return '${info.appName} ${info.device} ${info.os}';
}
