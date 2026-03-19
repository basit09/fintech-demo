import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  static const String _tokenKey = 'auth_token';
  static const String _biometricLoginEnabledKey = 'biometric_login_enabled';
  
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
  
  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _biometricLoginEnabledKey, value: enabled.toString());
  }
  
  Future<bool> isBiometricEnabled() async {
    final value = await _storage.read(key: _biometricLoginEnabledKey);
    return value == 'true';
  }
}
