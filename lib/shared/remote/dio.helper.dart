import 'package:dio/dio.dart';

class Diohelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? query,
    String Lang = 'en' ,
    String? Token ,
  }) async {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':Lang,
      'Authorization':'$Token',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String Lang = 'en' ,
    String? Token,
  }) async {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':Lang,
      'Authorization': '$Token',
    };
    return await dio.post(url, queryParameters: query ,data: data);
  }

  static Future<Response> PutData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String Lang = 'en' ,
    String? Token,
  }) async {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':Lang,
      'Authorization': '$Token',
    };
    return await dio.put(url, queryParameters: query ,data: data);
  }


}
