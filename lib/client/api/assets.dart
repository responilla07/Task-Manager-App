import 'package:task_manager/utils/app_info.dart';

// This is an example API of assets for images, files, and etc.
enum AssetsAPI {
  dev('https://sample-media-dev.com.ph/'),
  stg('https://sample-media-staging.com.ph/'),
  prd('https://sample-media.com.ph/');

  const AssetsAPI(this.url);
  final String url;
}

class AssetsURL {
  static String api(env) {
    switch (env) {
      case AppInfo.dev:
        return AssetsAPI.dev.url;
      case AppInfo.stg:
        return AssetsAPI.stg.url;
      case AppInfo.prd:
        return AssetsAPI.prd.url;
      default:
        return throw "Error Env";
    }
  }
}
