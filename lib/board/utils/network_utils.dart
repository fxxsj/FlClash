import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// 网络工具类
class NetworkUtils {
  /// 检查设备网络连接状态
  static Future<bool> isNetworkConnected() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      
      // 如果连接不是"none"，尝试进一步验证网络连通性
      try {
        final result = await InternetAddress.lookup('example.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('检查网络连接失败: $e');
      }
      return false;
    }
  }

  /// 使用重试机制执行网络请求
  /// 
  /// [apiCall] - API调用函数
  /// [maxRetries] - 最大重试次数
  /// [retryInterval] - 重试间隔(毫秒)
  static Future<T> retryRequest<T>({
    required Future<T> Function() apiCall,
    int maxRetries = 3,
    int retryInterval = 1000,
    bool Function(Exception)? shouldRetry,
  }) async {
    int attempts = 0;
    
    while (true) {
      try {
        return await apiCall();
      } on DioException catch (e) {
        attempts++;
        
        // 检查是否应该重试
        bool retry = attempts < maxRetries && await _shouldRetryRequest(e, shouldRetry);
        
        if (!retry) {
          rethrow;
        }
        
        if (kDebugMode) {
          debugPrint('请求失败，尝试重试 ($attempts/$maxRetries): ${e.message}');
        }
        
        // 等待指定间隔后重试
        await Future.delayed(Duration(milliseconds: retryInterval));
      }
    }
  }

  /// 判断是否应该重试请求
  static Future<bool> _shouldRetryRequest(
    DioException error, 
    bool Function(Exception)? shouldRetry,
  ) async {
    // 如果提供了自定义重试判断函数，使用它
    if (shouldRetry != null) {
      return shouldRetry(error);
    }
    
    // 默认重试条件：网络连接错误、超时错误、500系列服务器错误
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.response?.statusCode != null && 
         error.response!.statusCode! >= 500 && 
         error.response!.statusCode! < 600);
  }
} 