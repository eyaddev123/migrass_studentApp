import 'package:dio/dio.dart';
import 'package:student/core/api/api_consumer.dart';
import 'package:student/core/error/handle_dio_error.dart';


class DioConsumer implements ApiConsumer {
  final Dio dio = Dio(
    BaseOptions(
     //  baseUrl: "https://api.devscape.online",
      baseUrl: "http://192.168.43.127:4000",
    //  baseUrl: "http://localhost:4000",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  DioConsumer(dio);

  @override
  Future<Response> get(
    String path, {
    Object? data,
     num? id,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> post(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> patch(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> delete(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      HandleDioException(e);
      rethrow;
    }
  }
@override
Future<Response> put(
  String path, {
  bool is_need_data_to_map = false,
  Object? data,
  Map<String, dynamic>? queryParameters,
  Options? options,
}) async {
  try {
    final response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  } on DioException catch (e) {
    HandleDioException(e);
    rethrow;
  }
}

  
}
