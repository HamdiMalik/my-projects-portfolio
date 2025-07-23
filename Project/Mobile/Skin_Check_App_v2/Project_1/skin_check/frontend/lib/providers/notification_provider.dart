import 'package:flutter/material.dart';
import 'package:skincheck/models/notification.dart';
import 'package:skincheck/services/api_service.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationProvider() {
    _loadMockNotifications();
  }

  void _loadMockNotifications() {
    _notifications = [
      AppNotification(
        id: '1',
        title: 'Analysis Complete',
        message: 'Your skin scan results are ready. Tap to view details.',
        type: 'analysis',
        isRead: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      AppNotification(
        id: '2',
        title: 'Check-up Reminder',
        message: 'Time for your monthly skin self-examination.',
        type: 'reminder',
        isRead: false,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      AppNotification(
        id: '3',
        title: 'Skin Care Tip',
        message: 'Don\'t forget to use sunscreen with SPF 30+ daily.',
        type: 'tip',
        isRead: true,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
    notifyListeners();
  }

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.getNotifications();
      
      if (result['success']) {
        _notifications = (result['data']['notifications'] as List)
            .map((json) => AppNotification.fromJson(json))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print('Failed to load notifications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final result = await ApiService.markNotificationAsRead(notificationId);
      
      if (result['success']) {
        final index = _notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          _notifications[index] = AppNotification(
            id: _notifications[index].id,
            title: _notifications[index].title,
            message: _notifications[index].message,
            type: _notifications[index].type,
            isRead: true,
            timestamp: _notifications[index].timestamp,
          );
          notifyListeners();
        }
      }
    } catch (e) {
      print('Failed to mark notification as read: $e');
    }
  }

  void markAllAsRead() {
    _notifications = _notifications.map((notification) {
      return AppNotification(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        type: notification.type,
        isRead: true,
        timestamp: notification.timestamp,
      );
    }).toList();
    notifyListeners();
  }
}