import 'dart:convert';

import 'package:booking_app_mvp_test/core/api/response.dart';
import 'package:http/http.dart' as http;

import 'api_client.dart';
import 'apis.dart';

class ApiClientImpl extends ApiClient {
  @override
  Future<Response<T>> callGET<T>({
    String host = "bookingapi.redik.in",
    required Apis api,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? urlParams,
    required T Function(dynamic json,int code) parseResponse,
  }) async {
    try {
      var url = Uri.https(host, api.path(params: urlParams), queryParameters);
      var response = await http.get(url, headers: headers);
      var json = jsonDecode(response.body) ;
      print(json);
      return Response.fromJson(response.statusCode,json, parseResponse);
    } on Exception catch (e) {
      return Response(
        status: -1,
        data: parseResponse(null,500),
        message: e.toString(),
        error: null,
      );
    }
  }

  @override
  Future<Response<T>> callPOST<T>({
    String host = "bookingapi.redik.in",
    required Apis api,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, dynamic>? urlParams,
    required T Function(dynamic json,int code) parseResponse,
  }) async {
    try {
      var url = Uri.https(host, api.path(params: urlParams));
      var response = await http.post(url, headers: headers, body: params);
      var json = jsonDecode(response.body) ;
      print(json);
      return Response.fromJson(response.statusCode,json, parseResponse);
    } on Exception catch (e) {
      return Response(
        status: -1,
        data: parseResponse(null,500),
        message: e.toString(),
        error: null,
      );
    }
  }
}
