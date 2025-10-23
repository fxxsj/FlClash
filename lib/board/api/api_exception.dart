import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// API异常类
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;
  final String? requestPath;
  final dynamic originalError;

  ApiException({
    required this.message, 
    this.statusCode, 
    this.errorCode,
    this.requestPath,
    this.originalError,
  });

  /// 从 DioException 创建 ApiException
  factory ApiException.fromDioException(DioException error) {
    final response = error.response;
    final requestOptions = error.requestOptions;
    final path = requestOptions.path;

    // 处理各种错误情况
    if (error.type == DioExceptionType.connectionTimeout) {
      return ApiException(
        message: '连接超时，请检查您的网络',
        statusCode: 408,
        requestPath: path,
        originalError: error,
      );
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        message: '接收数据超时，请稍后重试',
        statusCode: 408,
        requestPath: path,
        originalError: error,
      );
    } else if (error.type == DioExceptionType.sendTimeout) {
      return ApiException(
        message: '发送数据超时，请稍后重试',
        statusCode: 408,
        requestPath: path,
        originalError: error,
      );
    } else if (error.type == DioExceptionType.cancel) {
      return ApiException(
        message: '请求已取消',
        requestPath: path,
        originalError: error,
      );
    } else if (error.type == DioExceptionType.badResponse) {
      // 处理服务器错误响应
      if (response != null) {
        String errorMessage = '服务器错误';
        int? statusCode = response.statusCode;

        // 尝试从响应中提取错误信息
        if (response.data is Map) {
          final data = response.data as Map<String, dynamic>;
          
          // 优先从errors中提取具体的错误信息
          if (data.containsKey('errors') && data['errors'] != null) {
            final errors = data['errors'];
            if (errors is Map && errors.isNotEmpty) {
              // 获取第一个错误字段的第一个错误信息
              final firstField = errors.values.first;
              if (firstField is List && firstField.isNotEmpty) {
                errorMessage = firstField.first.toString();
              } else if (firstField is String) {
                errorMessage = firstField;
              }
            }
          }
          
          // 如果errors中没有提取到有效错误信息，则使用message
          if (errorMessage == '服务器错误') {
            if (data.containsKey('message') && data['message'] != null) {
              errorMessage = data['message'].toString();
            } else if (data.containsKey('error') && data['error'] != null) {
              errorMessage = data['error'].toString();
            } else if (data.containsKey('msg') && data['msg'] != null) {
              errorMessage = data['msg'].toString();
            }
          }
        }

        return ApiException(
          message: errorMessage,
          statusCode: statusCode,
          requestPath: path,
          originalError: error,
        );
      }
    } else if (error.error is SocketException) {
      return ApiException(
        message: '网络连接失败，请检查您的网络',
        requestPath: path,
        originalError: error,
      );
    }

    // 默认错误处理 - 优先使用DioException的error字段
    String errorMessage = '请求失败';
    if (error.error != null) {
      errorMessage = error.error.toString();
    } else if (error.message != null) {
      errorMessage = error.message!;
    }

    return ApiException(
      message: errorMessage,
      requestPath: path,
      originalError: error,
    );
  }

  /// 从错误中提取用户友好的消息
  static String getUserFriendlyMessage(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error is DioException) {
      return ApiException.fromDioException(error).message;
    } else if (error is SocketException) {
      return '网络连接失败，请检查您的网络';
    } else {
      return error.toString();
    }
  }

  /// 显示错误提示对话框
  static void showErrorDialog(BuildContext context, dynamic error) {
    final message = getUserFriendlyMessage(error);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('发生错误'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 显示错误通知
  static void showErrorSnackbar(BuildContext context, dynamic error) {
    final message = getUserFriendlyMessage(error);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  String toString() => message;
}
