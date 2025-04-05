import "package:booking_app_mvp_test/core/api/response.dart";

import "apis.dart";

abstract class ApiClient {
  Future<Response<T>> callGET<T>({
    String host = "dev-admin.redikclassroom.com",
    required Apis api,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? urlParams,
    required T Function(dynamic json,int code) parseResponse,
  });

  Future<Response<T>> callPOST<T>({
    String host = "dev-admin.redikclassroom.com",
    required Apis api,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, dynamic>? urlParams,
    required T Function(dynamic,int code) parseResponse,
  });
}




