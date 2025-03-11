import 'package:flutter/material.dart';

import '../utility/constants.dart';
// import 'package:sm_app/core/utility/constants.dart';

enum ScreenType { mobile, tablet, desktop }

ScreenType getScreenType(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < Constants.maxMobileSize) {
    return ScreenType.mobile;
  } else if (screenWidth < Constants.maxTabletSize) {
    return ScreenType.tablet;
  } else {
    return ScreenType.desktop;
  }
}