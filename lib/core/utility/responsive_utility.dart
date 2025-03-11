import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveUtility {
  static bool isDesktop(BuildContext context) {
    return (context.size?.width ?? 0) > Constants.minDesktopSize;
  }

  static bool isTablet(BuildContext context) {
    final double width = context.size?.width ?? 0;
    return width > Constants.maxMobileSize && width < Constants.minDesktopSize;
  }

  static bool isMobile(BuildContext context) {
    return (context.size?.width ?? 0) < Constants.maxMobileSize;
  }

}