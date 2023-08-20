import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/utils/app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var configuredApp = const AppConfig(
    appTitle: 'Task Manager STG',
    buildFlavor: AppConfig.stg,
    child: App(),
  );

  runApp(configuredApp);
}
