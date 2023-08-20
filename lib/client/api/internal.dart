import 'package:task_manager/utils/app_info.dart';

// This is an example API made by internal team
enum InternalAPI {
  dev('https://9b7b-203-189-119-66.ngrok-free.app/'),
  stg('https://9b7b-203-189-119-66.ngrok-free.app/'),
  prd('https://9b7b-203-189-119-66.ngrok-free.app/');

  const InternalAPI(this.url);
  final String url;
}

class InternalURL {
  static String api(env) {
    switch (env) {
      case AppInfo.dev:
        return InternalAPI.dev.url;
      case AppInfo.stg:
        return InternalAPI.stg.url;
      case AppInfo.prd:
        return InternalAPI.prd.url;
      default:
        return throw "Error Env";
    }
  }
}
