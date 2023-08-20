import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  // APP PACKAGE NAME
  static const dev = 'com.example.task_manager.dev';
  static const stg = 'com.example.task_manager.stg';
  static const prd = 'com.example.task_manager';

  // APP Package name base on the App Environment we are running
  static env() async {
    PackageInfo info = await PackageInfo.fromPlatform();

    return info.packageName;
  }
}
