import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  static const String dev = 'Development';
  static const String stg = 'Staging';
  static const String prd = 'Production';

  final String appTitle;
  final String buildFlavor;

  const AppConfig({
    super.key,
    required this.appTitle,
    required this.buildFlavor,
    required Widget child,
  }) : super(child: child);

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
