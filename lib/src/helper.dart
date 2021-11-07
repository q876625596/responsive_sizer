part of responsive_sizer;

/// Type of Device
///
/// This can be android, ios, fuchsia, web, or desktop (windows, mac, linux)
enum DeviceType { android, ios, fuchsia, web, windows, mac, linux }

/// Type of Screen
///
/// This can either be mobile or tablet
enum SizerScreenType { watch, mobile, tablet, desktop }

class SizerDevice {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  static late DeviceType deviceType;

  /// Type of Screen
  static late SizerScreenType screenType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  static const double _defaultWatch = 300;
  static const double _defaultMobile = 600;
  static const double _defaultTablet = 1000;

  static late Map<SizerScreenType, double> screenTypeSizeMap = {
    SizerScreenType.watch: _defaultWatch,
    SizerScreenType.mobile: _defaultMobile,
    SizerScreenType.tablet: _defaultTablet,
  };

  /// Device's Aspect Ratio
  static double get aspectRatio {
    return WidgetsBinding.instance?.window.physicalSize.aspectRatio ?? 1;
  }

  /// Devices' Pixel Ratio
  static double get pixelRatio {
    return WidgetsBinding.instance?.window.devicePixelRatio ?? 1;
  }

  ///set screenTypeSizeMap
  static void setScreenTypeSize(Map<SizerScreenType, double> sizeMap) {
    screenTypeSizeMap = sizeMap;
  }

  /// Sets the Device's `Orientation`,
  static void setScreenOrientation(Orientation currentOrientation) {
    orientation = currentOrientation;
  }

  /// Sets the Device's type
  static void setDeviceType() {
    // Sets DeviceType
    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceType = DeviceType.android;
          break;
        case TargetPlatform.iOS:
          deviceType = DeviceType.ios;
          break;
        case TargetPlatform.windows:
          deviceType = DeviceType.windows;
          break;
        case TargetPlatform.macOS:
          deviceType = DeviceType.mac;
          break;
        case TargetPlatform.linux:
          deviceType = DeviceType.linux;
          break;
        case TargetPlatform.fuchsia:
          deviceType = DeviceType.fuchsia;
          break;
      }
    }
  }

  /// Sets the Screen's size and Device's `BoxConstraints`, `Height`, and `Width`
  static void setScreenType(BoxConstraints constraints) {
    // Sets boxConstraints
    boxConstraints = constraints;

    // Sets screen width and height
    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    // Sets ScreenType
    var watchSize = screenTypeSizeMap[SizerScreenType.watch] ?? _defaultWatch;
    var mobileSize = screenTypeSizeMap[SizerScreenType.mobile] ?? _defaultMobile;
    var tabletSize = screenTypeSizeMap[SizerScreenType.tablet] ?? _defaultTablet;
    if (width < watchSize) {
      screenType = SizerScreenType.watch;
    } else if (width < mobileSize) {
      screenType = SizerScreenType.mobile;
    } else if (width < tabletSize) {
      screenType = SizerScreenType.tablet;
    } else {
      screenType = SizerScreenType.desktop;
    }
  }
}

class Adaptive {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  static double h(num height) => height.h;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's width
  static double w(num width) => width.w;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  static double sp(num scalablePixel) => scalablePixel.sp;
}
