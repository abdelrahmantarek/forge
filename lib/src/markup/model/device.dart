


import 'package:flutter/material.dart';


DeviceType get getDeviceType {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? DeviceType.mobile :DeviceType.tablet;
}

bool get isTablet{
  return getDeviceType == DeviceType.tablet;
}

bool get isMobile{
  return getDeviceType == DeviceType.mobile;
}

enum DeviceType{
  mobile,
  tablet,
}
