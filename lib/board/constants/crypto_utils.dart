import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import '../config/security_config.dart';

/// 加密工具类
class CryptoUtils {
  CryptoUtils._();

  /// 解密方法
  static String decrypt(String encrypted) {
    try {
      if (kDebugMode) {
        debugPrint('开始解密，加密数据: $encrypted');
        debugPrint('加密数据长度: ${encrypted.length}');
      }

      final key = _deriveKey();
      if (kDebugMode) debugPrint('密钥生成成功，长度: ${key.length}');

      final bytes = _decodeHex(encrypted);
      if (kDebugMode) debugPrint('十六进制解码成功，数据长度: ${bytes.length}');

      final decrypted = _xorCipher(bytes, key);
      if (kDebugMode) debugPrint('XOR 解密完成，数据长度: ${decrypted.length}');

      if (!_verifyChecksum(decrypted)) {
        if (kDebugMode) {
          debugPrint('校验和验证失败');
          debugPrint('校验和: ${decrypted.sublist(0, 32)}');
          debugPrint('内容: ${decrypted.sublist(32)}');
        }
        return '';
      }
      if (kDebugMode) debugPrint('校验和验证通过');

      final jsonStr = utf8.decode(decrypted.sublist(32));
      if (kDebugMode) debugPrint('解密结果: $jsonStr');
      return jsonStr;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('解密错误: $e');
        debugPrint('错误堆栈: $stackTrace');
      }
      return '';
    }
  }

  /// 生成密钥
  static List<int> _deriveKey() {
    final salt = utf8.encode(SecurityConfig.encryptionSalt);
    final key = utf8.encode(SecurityConfig.encryptionKey);

    final hmac = Hmac(sha256, salt);
    final digest = hmac.convert(key);
    return digest.bytes;
  }

  /// XOR 加密
  static List<int> _xorCipher(List<int> data, List<int> key) {
    if (data.isEmpty || key.isEmpty) {
      throw Exception('数据或密钥不能为空');
    }
    final result = List<int>.filled(data.length, 0);
    for (var i = 0; i < data.length; i++) {
      result[i] = data[i] ^ key[i % key.length];
    }
    return result;
  }

  /// 十六进制解码
  static List<int> _decodeHex(String hex) {
    if (hex.isEmpty || hex.length % 2 != 0) {
      throw Exception('无效的十六进制字符串');
    }
    final result = List<int>.empty(growable: true);
    for (var i = 0; i < hex.length; i += 2) {
      try {
        result.add(int.parse(hex.substring(i, i + 2), radix: 16));
      } catch (e) {
        throw Exception('无效的十六进制字符: ${hex.substring(i, i + 2)}');
      }
    }
    return result;
  }

  /// 校验和验证
  static bool _verifyChecksum(List<int> data) {
    if (data.length < 32) {
      if (kDebugMode) debugPrint('数据长度不足，无法验证校验和');
      return false;
    }
    final checksum = data.sublist(0, 32);
    final content = data.sublist(32);
    final calculated = sha256.convert(content).bytes;
    return const ListEquality().equals(checksum, calculated);
  }

  /// 验证加密配置的完整性
  static bool validateEncryptionConfig() {
    try {
      if (SecurityConfig.encryptionKey.isEmpty ||
          SecurityConfig.encryptionSalt.isEmpty) {
        if (kDebugMode) debugPrint('加密配置不完整');
        return false;
      }
      // 验证密钥长度
      if (SecurityConfig.encryptionKey.length < 16) {
        if (kDebugMode) debugPrint('加密密钥长度不足');
        return false;
      }
      // 验证盐值长度
      if (SecurityConfig.encryptionSalt.length < 8) {
        if (kDebugMode) debugPrint('加密盐值长度不足');
        return false;
      }
      return true;
    } catch (e) {
      if (kDebugMode) debugPrint('验证加密配置时出错: $e');
      return false;
    }
  }
}
