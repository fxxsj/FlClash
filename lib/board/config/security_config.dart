class SecurityConfig {
  SecurityConfig._();

  static String _encryptionKey = '';
  static String _encryptionSalt = '';

  static init() {
    _encryptionKey = 'FxClash@app@specific_key';
    _encryptionSalt = 'FxClash@salt@2024';
  }

  /// 获取加密密钥
  static String get encryptionKey => _encryptionKey;

  /// 获取加密盐值
  static String get encryptionSalt => _encryptionSalt;
}
