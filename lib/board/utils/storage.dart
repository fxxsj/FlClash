import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  final SharedPreferences _prefs;
  static const String _tokenKey = 'auth_token';
  static const String _emailKey = 'auth_email';

  AuthStorage(this._prefs);

  String? get token => _prefs.getString(_tokenKey);
  String? get email => _prefs.getString(_emailKey);

  Future<void> saveAuth(String token, String email) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setString(_emailKey, email);
  }

  Future<void> clearAuth() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_emailKey);
  }
} 