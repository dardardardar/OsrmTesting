import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width <= 500.0;
  bool get isMobileSmall => MediaQuery.sizeOf(this).width <= 360.0;

  bool get isTablet =>
      MediaQuery.sizeOf(this).width < 1024.0 &&
      MediaQuery.sizeOf(this).width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.sizeOf(this).width < 650.0 &&
      MediaQuery.sizeOf(this).width > 500.0;

  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1024.0;

  bool get isSmall =>
      MediaQuery.sizeOf(this).width < 850.0 &&
      MediaQuery.sizeOf(this).width >= 560.0;

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  Size get size => MediaQuery.sizeOf(this);
}
