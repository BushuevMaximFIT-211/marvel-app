import 'package:dio/dio.dart';

abstract class HttpService {
  static final Dio _dio = Dio();
  static Future<Response> getRequest(String baseUrl, String endPoint,
      Map<String, dynamic> queryParameters) async {
    _dio.options.baseUrl = baseUrl;
    Response response;
    try {
      response = await _dio.get(endPoint, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}
