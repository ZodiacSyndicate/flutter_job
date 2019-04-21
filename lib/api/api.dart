import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show required;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class Request {
  var dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.0.105:3500',
      contentType: ContentType.parse('application/x-www-form-urlencoded')));

  Request() {
    getTemporaryDirectory().then((tempDir) {
      String tempPath = tempDir.path;
      CookieJar cj = PersistCookieJar(dir: tempPath);
      dio.interceptors.add(CookieManager(cj));
      dio.interceptors.add(LogInterceptor());
    });
  }

  Future<Response<Map>> register(
          {@required String username,
          @required String password,
          @required String type}) =>
      dio.post<Map>('/user/register',
          data: {'username': username, 'password': password, 'type': type});
}
