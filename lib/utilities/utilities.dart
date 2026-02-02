import 'package:flutter/material.dart';

class NZUtilities {
  /// 检查当前设备是否为横屏
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// 检查当前设备是否为竖屏
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// 检查当前设备是否为平板电脑
  ///
  /// 我们通过屏幕的最短边是否大于 600 逻辑像素来判断。
  /// 这是一种通用的 Material Design 判断标准。
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  /// 检查当前设备是否为手机
  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }
}
