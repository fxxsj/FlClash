import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:fl_clash/common/network_manager.dart';

class Request {
  Request() {
    // 初始化全局网络管理器
    networkManager.initialize();
  }

  Future<Response> getFileResponseForUrl(String url) async {
    return networkManager.getFileResponse(url);
  }

  Future<Response> getTextResponseForUrl(String url) async {
    return networkManager.getTextResponse(url);
  }

  Future<MemoryImage?> getImage(String url) async {
    return networkManager.getImage(url);
  }

  Future<Map<String, dynamic>?> checkForUpdate() async {
    return networkManager.checkForUpdate();
  }

  Future<Result<IpInfo?>> checkIp({CancelToken? cancelToken}) async {
    return networkManager.checkIp(cancelToken: cancelToken);
  }

  Future<bool> pingHelper() async {
    return networkManager.pingHelper();
  }

  Future<bool> startCoreByHelper(String arg) async {
    return networkManager.startCoreByHelper(arg);
  }

  Future<bool> stopCoreByHelper() async {
    return networkManager.stopCoreByHelper();
  }
}

final request = Request();
