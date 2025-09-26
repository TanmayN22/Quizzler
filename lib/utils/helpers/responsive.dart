import 'package:get/get.dart';

// This is a design reference,an iPhone 11 has a logical width of 375 and height of 812.
const double _referenceHeight = 812.0;
const double _referenceWidth = 375.0;

extension ResponsiveDouble on num {
  /// Returns a calculated height based on the device's screen height.
  double get h => this * (Get.height / _referenceHeight);

  /// Returns a calculated width based on the device's screen width.
  double get w => this * (Get.width / _referenceWidth);
}