import 'dart:convert';

class Response<T> {
  final int status;
  final T data;
  final String? message;
  final String? error;

  const Response({
    required this.status,
    required this.data,
    required this.message,
    required this.error,
  });

  factory Response.fromJson(
      int status,
    dynamic json,
    T Function(dynamic json,int code) parseResponse,
  ) {
    return Response(
      status: status,
      message: json is Map ?json['message']:null,
      error: json is Map ?json['error']:null,
      data: parseResponse(json,status),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "status": status,
      "message": message,
      "error": error,
      "data": jsonEncode(data),
    };
  }
}
