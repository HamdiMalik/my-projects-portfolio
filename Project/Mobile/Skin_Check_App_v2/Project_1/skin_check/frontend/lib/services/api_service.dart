import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:skincheck/models/user.dart';
import 'package:skincheck/models/scan.dart';
import 'package:skincheck/models/notification.dart';
import 'package:skincheck/services/storage_service.dart';

class ApiService {
  static const String baseUrl = 'https://55cafd4b524c.ngrok-free.app/api/v1';
  static const Duration timeout = Duration(seconds: 30);
  
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: timeout,
    receiveTimeout: timeout,
    headers: {'Content-Type': 'application/json'},
  ));

  static final CookieJar cookieJar = CookieJar();

  // Callback yang bisa di-set dari luar untuk redirect ke login
  static Function()? onUnauthorized;

  // Hapus seluruh logic token/Authorization/refresh token dari interceptor
  static void setupInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(CookieManager(cookieJar));
    // Tidak perlu InterceptorsWrapper untuk Authorization/token
  }

  // Hapus seluruh logic _refreshToken, token, dan Authorization header di semua method
  // Semua request cukup pakai Dio + CookieManager, tanpa header Authorization
  // Authentication
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      setupInterceptors();
      
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Login failed'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    try {
      setupInterceptors();
      final response = await _dio.post('/auth/register', data: userData);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Registration failed'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      setupInterceptors();
      final response = await _dio.post('/auth/forgot-password', data: {'email': email});
      return {'success': true, 'message': response.data['message']};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to send reset email'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  // User Profile
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      setupInterceptors();
      final response = await _dio.get('/users/profile');
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to get profile'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateProfile(Map<String, String> userData) async {
    try {
      setupInterceptors();
      final response = await _dio.put('/users/profile', data: userData);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to update profile'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  // Scans
  static Future<Map<String, dynamic>> getScans({int page = 1, int perPage = 20}) async {
    try {
      setupInterceptors();
      
      final response = await _dio.get('/scans', queryParameters: {
        'page': page,
        'per_page': perPage,
      });
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to get scans'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> createScan(Map<String, dynamic> scanData) async {
    try {
      setupInterceptors();
      
      final response = await _dio.post('/scans', data: scanData);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to create scan'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> syncScans(List<Map<String, dynamic>> scans) async {
    try {
      setupInterceptors();
      final response = await _dio.post('/scans/sync', data: {'scans': scans});
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to sync scans'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  // Public scan endpoint - no authentication required
  static Future<Map<String, dynamic>> scanImage(String imagePath) async {
    try {
      // Create a new Dio instance for file upload (without authentication)
      final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
      ));

      // Create form data with image file
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath, filename: 'scan.jpg'),
      });

      final response = await dio.post('/scans/scan', data: formData);
      
      if (response.statusCode == 200) {
        return {
          'success': true, 
          'result': response.data['result']
        };
      } else {
        return {
          'success': false, 
          'error': 'Scan failed: ${response.statusCode}'
        };
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          'success': false, 
          'error': e.response?.data['error'] ?? 'Scan failed'
        };
      }
      return {
        'success': false, 
        'error': 'Network error: ${e.message}'
      };
    } catch (e) {
      return {
        'success': false, 
        'error': 'Unexpected error: $e'
      };
    }
  }

  // Notifications
  static Future<Map<String, dynamic>> getNotifications({int page = 1, int perPage = 20}) async {
    try {
      setupInterceptors();
      final response = await _dio.get('/notifications', queryParameters: {
        'page': page,
        'per_page': perPage,
      });
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to get notifications'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> markNotificationAsRead(String notificationId) async {
    try {
      setupInterceptors();
      final response = await _dio.put('/notifications/$notificationId/read');
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to mark as read'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  // Mobile-specific endpoints
  static Future<Map<String, dynamic>> getAppConfig() async {
    try {
      setupInterceptors();
      final response = await _dio.get('/mobile/app-config');
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': 'Failed to get app config'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> registerDevice(Map<String, dynamic> deviceInfo) async {
    try {
      setupInterceptors();
      final response = await _dio.post('/mobile/device-info', data: deviceInfo);
      return {'success': true, 'data': response.data};
    } on DioException catch (e) {
      if (e.response != null) {
        return {'success': false, 'error': e.response?.data['error'] ?? 'Failed to register device'};
      }
      return {'success': false, 'error': 'Network error: ${e.message}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  // Health check
  static Future<bool> checkHealth() async {
    try {
      setupInterceptors();
      final response = await _dio.get('/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}