import 'package:bayat/core/Netwirking/bBaseUr.dart';
import 'package:dio/dio.dart';

import '../errors/expentions.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  static final DioConsumer _instance = DioConsumer._internal(Dio());

  final Dio dio;

  DioConsumer._internal(this.dio) {
    dio.options.baseUrl = BaseUrl.Baseurl;
  }

  factory DioConsumer() {
    return _instance;
  }

  //!POST
  @override
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        Map<String, String>? headers, // ⬅️ إضافة
      }) async {
    try {
      var res = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!GET
  @override
  Future get(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers, // ⬅️ إضافة
      }) async {
    try {
      var res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!DELETE
  @override
  Future delete(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers, // ⬅️ إضافة
      }) async {
    try {
      var res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!PATCH
  @override
  Future patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData = false,
        Map<String, String>? headers, // ⬅️ إضافة
      }) async {
    try {
      var res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
