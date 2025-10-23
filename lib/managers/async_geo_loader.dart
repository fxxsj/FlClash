import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:fl_clash/common/common.dart';

/// 异步Geo数据加载器
class AsyncGeoLoader {
  static AsyncGeoLoader? _instance;
  static AsyncGeoLoader get instance => _instance ??= AsyncGeoLoader._();
  
  AsyncGeoLoader._();

  /// Geo文件列表
  static const List<String> _geoFileNames = [
    mmdbFileName,
    geoIpFileName,
    geoSiteFileName,
    asnFileName,
  ];

  /// 加载状态
  bool _isLoading = false;
  bool _isCompleted = false;
  String? _error;

  /// 加载进度回调
  Function(double progress, String fileName)? _progressCallback;

  /// 获取加载状态
  bool get isLoading => _isLoading;
  bool get isCompleted => _isCompleted;
  String? get error => _error;

  /// 设置进度回调
  void setProgressCallback(Function(double progress, String fileName)? callback) {
    _progressCallback = callback;
  }

  /// 异步加载Geo数据（后台执行）
  Future<void> loadGeoDataAsync() async {
    if (_isLoading || _isCompleted) return;
    
    _isLoading = true;
    _error = null;

    try {
      if (kDebugMode) {
        debugPrint('🌍 开始异步加载Geo数据...');
      }

      // 在后台isolate中执行Geo数据加载
      await _loadGeoDataInBackground();
      
      _isCompleted = true;
      if (kDebugMode) {
        debugPrint('✅ Geo数据异步加载完成');
      }

    } catch (e, stackTrace) {
      _error = e.toString();
      if (kDebugMode) {
        debugPrint('❌ Geo数据加载失败: $e');
        debugPrint('堆栈跟踪: $stackTrace');
      }
    } finally {
      _isLoading = false;
    }
  }

  /// 在后台加载Geo数据
  Future<void> _loadGeoDataInBackground() async {
    final homePath = await appPath.homeDirPath;
    
    // 确保目录存在
    final homeDir = Directory(homePath);
    if (!await homeDir.exists()) {
      await homeDir.create(recursive: true);
    }

    // 检查哪些文件需要加载
    final filesToLoad = <String>[];
    for (final fileName in _geoFileNames) {
      final file = File(join(homePath, fileName));
      if (!await file.exists()) {
        filesToLoad.add(fileName);
      }
    }

    if (filesToLoad.isEmpty) {
      if (kDebugMode) {
        debugPrint('所有Geo文件已存在，跳过加载');
      }
      return;
    }

    if (kDebugMode) {
      debugPrint('需要加载的Geo文件: ${filesToLoad.join(', ')}');
    }

    // 逐个加载文件
    for (int i = 0; i < filesToLoad.length; i++) {
      final fileName = filesToLoad[i];
      final progress = (i + 1) / filesToLoad.length;
      
      _progressCallback?.call(progress, fileName);
      
      await _loadSingleGeoFile(homePath, fileName);
    }
  }

  /// 加载单个Geo文件
  Future<void> _loadSingleGeoFile(String homePath, String fileName) async {
    try {
      final geoFile = File(join(homePath, fileName));
      
      if (kDebugMode) {
        debugPrint('正在加载: $fileName');
      }

      // 从assets加载数据
      final data = await rootBundle.load('assets/data/$fileName');
      final bytes = data.buffer.asUint8List();
      
      // 写入文件
      await geoFile.writeAsBytes(bytes, flush: true);
      
      if (kDebugMode) {
        final sizeKB = (bytes.length / 1024).toStringAsFixed(1);
        debugPrint('✓ $fileName 加载完成 (${sizeKB}KB)');
      }

    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠ $fileName 加载失败: $e');
      }
      throw Exception('加载Geo文件失败: $fileName - $e');
    }
  }

  /// 同步检查Geo数据是否就绪
  Future<bool> isGeoDataReady() async {
    try {
      final homePath = await appPath.homeDirPath;
      
      for (final fileName in _geoFileNames) {
        final file = File(join(homePath, fileName));
        if (!await file.exists()) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 强制重新加载Geo数据
  Future<void> reloadGeoData() async {
    _isCompleted = false;
    _error = null;
    await loadGeoDataAsync();
  }

  /// 获取Geo文件大小信息
  Future<Map<String, int>> getGeoFileSizes() async {
    final sizes = <String, int>{};
    
    try {
      final homePath = await appPath.homeDirPath;
      
      for (final fileName in _geoFileNames) {
        final file = File(join(homePath, fileName));
        if (await file.exists()) {
          final stat = await file.stat();
          sizes[fileName] = stat.size;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('获取Geo文件大小失败: $e');
      }
    }
    
    return sizes;
  }

  /// 清理Geo数据（用于测试或重置）
  Future<void> clearGeoData() async {
    try {
      final homePath = await appPath.homeDirPath;
      
      for (final fileName in _geoFileNames) {
        final file = File(join(homePath, fileName));
        if (await file.exists()) {
          await file.delete();
        }
      }
      
      _isCompleted = false;
      if (kDebugMode) {
        debugPrint('Geo数据已清理');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('清理Geo数据失败: $e');
      }
    }
  }

  /// 获取加载状态摘要
  Map<String, dynamic> getLoadingStatus() {
    return {
      'isLoading': _isLoading,
      'isCompleted': _isCompleted,
      'error': _error,
      'fileCount': _geoFileNames.length,
    };
  }
}

/// 全局异步Geo加载器实例
final asyncGeoLoader = AsyncGeoLoader.instance;