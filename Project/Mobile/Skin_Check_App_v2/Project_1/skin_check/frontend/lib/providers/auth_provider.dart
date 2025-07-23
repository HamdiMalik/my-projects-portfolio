import 'package:flutter/material.dart';
import 'package:skincheck/models/user.dart';
import 'package:skincheck/models/scan.dart';
import 'package:skincheck/services/api_service.dart';
import 'package:skincheck/services/storage_service.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await StorageService.getToken();
      if (token != null && token.isNotEmpty) {
        final user = await StorageService.getUser();
        if (user != null) {
          _user = user;
          _isAuthenticated = true;
          
          // Verify token is still valid by making a test API call
          try {
            final result = await ApiService.getProfile();
            if (!result['success'] && result['error']?.contains('Authentication required') == true) {
              // Token is invalid, clear it
              await logout();
            }
          } catch (e) {
            print('Token validation failed: $e');
            await logout();
          }
        }
      }
    } catch (e) {
      print('Error checking auth status: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.login(email, password);

      if (result['success']) {
        final data = result['data'];
        final user = User.fromJson(data['user']);

        await StorageService.saveTokens(
          data['access_token'],
          data['refresh_token'],
        );
        print('Token setelah login/register: access=${data['access_token']}, refresh=${data['refresh_token']}');
        await StorageService.saveUser(user);

        _user = user;
        _isAuthenticated = true;

        ApiService.setupInterceptors(); // Pastikan interceptor aktif dengan token baru
        await _syncCachedData(); // Baru sync scan

        _isLoading = false;
        notifyListeners();
        return {'success': true};
      } else {
        _isLoading = false;
        notifyListeners();
        return result;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'error': 'Login failed: $e'};
    }
  }

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.register(userData);

      if (result['success']) {
        final data = result['data'];
        final user = User.fromJson(data['user']);

        await StorageService.saveTokens(
          data['access_token'],
          data['refresh_token'],
        );
        print('Token setelah login/register: access=${data['access_token']}, refresh=${data['refresh_token']}');
        await StorageService.saveUser(user);

        _user = user;
        _isAuthenticated = true;

        ApiService.setupInterceptors(); // Pastikan interceptor aktif dengan token baru
        // Tidak perlu sync data di register, bisa dipanggil jika perlu

        _isLoading = false;
        notifyListeners();
        return {'success': true};
      } else {
        _isLoading = false;
        notifyListeners();
        return result;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'error': 'Registration failed: $e'};
    }
  }

  Future<void> logout() async {
    await StorageService.clearTokens();
    await StorageService.clearUser();

    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, String> userData) async {
    try {
      final result = await ApiService.updateProfile(userData);

      if (result['success']) {
        final user = User.fromJson(result['data']['user']);
        await StorageService.saveUser(user);
        _user = user;
        notifyListeners();
      }

      return result;
    } catch (e) {
      return {'success': false, 'error': 'Update failed: $e'};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      return await ApiService.forgotPassword(email);
    } catch (e) {
      return {'success': false, 'error': 'Failed to send reset email: $e'};
    }
  }

  Future<void> _syncCachedData() async {
    try {
      final cachedScansRaw = await StorageService.getScans();
      final List<Scan> cachedScans = cachedScansRaw.cast<Scan>();

      final unsyncedScans = cachedScans.where((scan) => !scan.synced).toList();

      if (unsyncedScans.isNotEmpty) {
        print('Syncing ${unsyncedScans.length} cached scans...');

        final scansData = unsyncedScans.map((scan) => scan.toJson()).toList();
        final result = await ApiService.syncScans(scansData);

        if (result['success']) {
          final updatedScans = cachedScans.map((scan) {
            return Scan(
              id: scan.id,
              imagePath: scan.imagePath,
              result: scan.result,
              timestamp: scan.timestamp,
              synced: true,
            );
          }).toList();

          await StorageService.saveScans(updatedScans);
          print('✅ All cached scans synced successfully');
        }
      }
    } catch (e) {
      print('❌ Error syncing cached data: $e');
    }
  }

  int getUnsyncedCount() {
    // Placeholder — implement if needed
    return 0;
  }

  // Hapus fungsi refreshToken manual karena sudah dihandle di interceptor Dio
}
