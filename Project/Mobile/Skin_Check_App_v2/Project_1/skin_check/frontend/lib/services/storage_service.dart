import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skincheck/models/user.dart';
import 'package:skincheck/models/scan.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage();
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _scansKey = 'scan_results';

  // Token management
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _secureStorage.write(key: _tokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // User data
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Scan results (offline storage)
  static Future<void> saveScans(List<Scan> scans) async {
    final prefs = await SharedPreferences.getInstance();
    final scansJson = scans.map((scan) => scan.toJson()).toList();
    await prefs.setString(_scansKey, jsonEncode(scansJson));
  }

  static Future<List<Scan>> getScans() async {
    final prefs = await SharedPreferences.getInstance();
    final scansData = prefs.getString(_scansKey);
    if (scansData != null) {
      final List<dynamic> scansJson = jsonDecode(scansData);
      return scansJson.map((json) => Scan.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> addScan(Scan scan) async {
    final scans = await getScans();
    scans.insert(0, scan);
    await saveScans(scans);
  }

  static Future<void> clearScans() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_scansKey);
  }

  // General preferences
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? defaultValue;
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Clear all data
  static Future<void> clearAll() async {
    await clearTokens();
    await clearUser();
    await clearScans();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}