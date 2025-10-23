import 'package:dio/dio.dart';

class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? message;

  ApiResponse({
    this.data,
    required this.success,
    this.message,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return ApiResponse(
      data: json['data'] != null ? fromJson(json['data']) : null,
      success: json['success'] ?? true,
      message: json['message'],
    );
  }

  factory ApiResponse.fromResponse(
    Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.data is! Map<String, dynamic>) {
      throw FormatException('Invalid response format');
    }

    final json = response.data as Map<String, dynamic>;
    return ApiResponse.fromJson(json, fromJson);
  }
}
