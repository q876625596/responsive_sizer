part of responsive_sizer;

/// Provides `Context`, `Orientation`, and `ScreenType` parameters to the builder function
typedef ResponsiveSizerType = Widget Function(
  BuildContext,
  Orientation,
  SizerScreenType,
);

typedef ResponsiveBuilderType = Widget Function(
  BuildContext,
  SizerScreenType,
);

/// A widget that gets the device's details like orientation and constraints
///
/// Usage: Wrap MaterialApp with this widget
class ResponsiveSizer extends StatelessWidget {
  const ResponsiveSizer({Key? key, required this.builder}) : super(key: key);

  /// Builds the widget whenever the orientation changes
  final ResponsiveSizerType builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizerDevice.setScreenType(constraints);
      SizerDevice.setDeviceType();
      return OrientationBuilder(builder: (context, orientation) {
        SizerDevice.setScreenOrientation(orientation);
        return builder(context, orientation, SizerDevice.screenType);
      });
    });
  }
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  /// Builds the widget whenever the orientation changes
  final ResponsiveBuilderType builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return builder(context, SizerDevice.screenType);
    });
  }
}
