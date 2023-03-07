import 'package:dio/dio.dart';

import '../constants/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json;multipart/form-data',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required dynamic body,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      data: body,
    );
  }

  static Future<Response> verifyPhoneSocial({
    required String url,
    required dynamic body,
    required String token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      data: body,
    );
  }

  static Future<Response> putData({
    required String url,
    required dynamic body,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url,
      data: body,
    );
  }
}
