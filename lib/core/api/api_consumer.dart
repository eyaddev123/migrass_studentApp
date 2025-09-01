import 'package:dio/dio.dart';


abstract class ApiConsumer {
  Future<Response> get(
    String path, {
    Object? data,
    num? id,
    Map<String, dynamic>? queryParameters,
   
    Options? options,
  });

  Future<Response> post(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

 Future<Response> patch(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

 Future<Response> delete(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response> put(
    String path, {
    bool is_need_data_to_map = false,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

}
