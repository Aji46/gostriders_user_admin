import 'package:flutter/material.dart';

/// Simple breakpoint-based responsive helper used across the app.
class Responsive {
  Responsive._();

  static const double mobileMax = 650;
  static const double tabletMax = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Number of grid columns for the product grid based on width.
  static int productGridColumns(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1400) return 5;
    if (w >= tabletMax) return 4;
    if (w >= mobileMax) return 3;
    if (w >= 420) return 2;
    return 1;
  }

  /// Horizontal page padding that scales with screen size.
  static double pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 64;
    if (w >= mobileMax) return 32;
    return 16;
  }

  /// Clamp content to a max width on very large screens, centered.
  static double contentMaxWidth = 1400;
}
