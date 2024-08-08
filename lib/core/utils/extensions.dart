import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.sizeOf(this).width <= 500.0;
  bool get isMobileSmall => MediaQuery.sizeOf(this).width <= 380.0;

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
