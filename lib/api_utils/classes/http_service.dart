import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio = Dio();

  final String baseUrl;

  HttpService(this.baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> getRequest(
      String endPoint, Map<String, dynamic> queryParameters) async {
    Response response;
    try {
      response = await _dio.get(endPoint, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}
