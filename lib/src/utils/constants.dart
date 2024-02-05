import 'package:flutter/material.dart';

import 'responsive.dart';

class AppConstants {
  static const appName = 'Flood Alert App';

  // Responsive breakpoints
  static const tabWidth = 600;
  static const desktopWidth = 1200;

  // Font sizes
  static const double fontSizeSmall = 18;
  static const double fontSizeMedium = 22;
  static const double fontSizeLarge = 26;

  // Padding
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;

  // Icon sizes
  static const double iconSizeSmall = 30;
  static const double iconSizeMedium = 40;
  static const double iconSizeLarge = 50;

  // Button dimensions
  static const double buttonHeightSmall = 40;
  static const double buttonHeightMedium = 50;
  static const double buttonHeightLarge = 60;

  // Button corner radius
  static const double buttonCornerRadiusSmall = 20;
  static const double buttonCornerRadiusMedium = 25;
  static const double buttonCornerRadiusLarge = 30;

  // Text Styles
  static TextStyle titleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtil.responsiveFontSize(context),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle subtitleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtil.responsiveFontSize(context) - 2,
      color: Theme.of(context).colorScheme.secondary,
    );
  }

  static TextStyle titleStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveUtil.responsiveFontSize(context),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}
