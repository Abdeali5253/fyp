import 'package:flutter/material.dart';
import 'constants.dart';

class ResponsiveUtil {
  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= AppConstants.desktopWidth;
  }

  static double responsiveFontSize(BuildContext context) {
    if (isDesktop(context)) {
      return AppConstants.fontSizeLarge;
    } else if (isTablet(context)) {
      return AppConstants.fontSizeMedium;
    } else {
      return AppConstants.fontSizeSmall;
    }
  }

  static double responsivePadding(BuildContext context) {
    if (isDesktop(context)) {
      return AppConstants.paddingLarge;
    } else if (isTablet(context)) {
      return AppConstants.paddingMedium;
    } else {
      return AppConstants.paddingSmall;
    }
  }

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
