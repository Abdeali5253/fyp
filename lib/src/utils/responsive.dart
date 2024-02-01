import 'package:flutter/material.dart';
import 'constants.dart';

class ResponsiveUtil {
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.shortestSide;
    return screenWidth > AppConstants.tabWidth;
  }

  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }

  static double responsiveValue({
    required BuildContext context,
    required double mobile,
    double? mobileLandscape,
    required double tablet,
  }) {
    if (isTablet(context)) {
      return tablet;
    } else if (isMobile(context) && !isPortrait(context)) {
      return mobileLandscape ?? mobile;
    } else {
      return mobile;
    }
  }
}
