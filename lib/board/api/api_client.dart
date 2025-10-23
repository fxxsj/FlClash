import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fl_clash/common/network_manager.dart';
import '../utils/storage.dart';

class ApiClient {
  final AuthStorage _storage;
  final String _baseUrl;

  ApiClient(this._storage, this._baseUrl) {
    // 初始化全局网络管理器
    networkManager.initialize(authStorage: _storage);
    _updateBaseUrl(_baseUrl);
  }

  void _updateBaseUrl(String newBaseUrl) {
    networkManager.updateBaseUrl(newBaseUrl);
  }


  // 为了兼容现有代码，提供dio getter
  Dio get dio => networkManager.directDio;

  // 简化的API方法，直接使用NetworkManager
  Future<Response> smartRequest({
    required Future<Response> Function(Dio dio) requestFunc,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return networkManager.smartRequest(
      requestFunc: requestFunc,
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }
  
  Future<Response> retryRequest(
    Future<Response> Function() apiCall, {
    int maxRetries = 3,
  }) async {
    return networkManager.retryRequest(
      apiCall,
      maxRetries: maxRetries,
    );
  }
  
  Future<Response> safeGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return networkManager.get(
      path,
      queryParameters: queryParameters,
      options: options,
      maxRetries: maxRetries,
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }
  
  Future<Response> safePost(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return networkManager.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      maxRetries: maxRetries,
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }
}