import 'package:task_manager/utils/app_info.dart';

// This is an example API made by external team
enum ExternalAPI {
  dev('https://sample-external-dev.com.ph/'),
  stg('https://sample-external-staging.com.ph/'),
  prd('https://sample-external.com.ph/');

  const ExternalAPI(this.url);
  final String url;
}

class ExternalURL {
  static String api(env) {
    switch (env) {
      case AppInfo.dev:
        return ExternalAPI.dev.url;
      case AppInfo.stg:
        return ExternalAPI.stg.url;
      case AppInfo.prd:
        return ExternalAPI.prd.url;
      default:
        return throw "Error Env";
    }
  }
}
