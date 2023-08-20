import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:task_manager/client/api/assets.dart';
import 'package:task_manager/client/api/external.dart';
import 'package:task_manager/client/api/internal.dart';
import 'package:task_manager/utils/app_info.dart';

import 'model/request.dart';

class RequestAPI {
  static Uri uri(baseUrl) => Uri.parse(baseUrl);
  static String authToken = '';

  static headers() {
    return {
      HttpHeaders.authorizationHeader: "Bearer $authToken",
      "content-type": "application/json; charset=utf-8",
      "content-security-policy": "default-src self",
      "x-content-type-options": "nosniff",
      "x-xss-protection": "1 mode=block",
      "strict-transport-security":
          "max-age=63072000; includeSubDomains; preload",
    };
  }

  static String getURL(ApiOf api, String env) {
    switch (api) {
      case ApiOf.internal:
        return InternalURL.api(env);
      case ApiOf.external:
        return ExternalURL.api(env);
      case ApiOf.assets:
        return AssetsURL.api(env);
      default:
        return throw "Error getting the URL";
    }
  }

  send(RequestModel req) async {
    late http.Response httpResponse;
    var env = await AppInfo.env();
    var url = uri(getURL(req.url, env) + req.endpoint);

    if (req.type == RequestType.get) {
      // GET DATA
      httpResponse = await http.get(url, headers: await headers());
    } else if (req.type == RequestType.post) {
      // POST DATA
      httpResponse = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode(req.data),
      );
    } else if (req.type == RequestType.delete) {
      // DELETE DATA
      httpResponse = await http.delete(url, headers: await headers());
    } else if (req.type == RequestType.patch) {
      httpResponse = await http.patch(
        url,
        headers: await headers(),
        body: jsonEncode(req.data),
      );
    } else if (req.type == RequestType.put) {
      // TODO implement method here
      throw 'request not implemented.';
    } else if (req.type == RequestType.update) {
      // TODO implement method here
      throw 'request not implemented.';
    }

    if (httpResponse.statusCode == 200) {
      return jsonDecode(httpResponse.body);
    } else {
      throw jsonDecode(httpResponse.body)['message'];
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////

  fetchConcurrencyData({List<RequestModel>? asd}) async {
    final results = await Future.wait([
      http.get(uri('url1')),
      http.get(uri('url2')),
    ]);

    return results;
  }

  hello() {
    fetchConcurrencyData(asd: [
      const RequestModel(
        url: ApiOf.external,
        type: RequestType.get,
        endpoint: '',
      ),
      const RequestModel(
        url: ApiOf.assets,
        type: RequestType.get,
        endpoint: 'profile.png',
      ),
      const RequestModel(
        url: ApiOf.internal,
        type: RequestType.get,
        endpoint: 'profile/details?id=123123',
      ),
    ]);
  }
}
