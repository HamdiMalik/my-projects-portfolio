import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincheck/providers/notification_provider.dart';
import 'package:skincheck/utils/theme.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              if (provider.unreadCount > 0) {
                return TextButton(
                  onPressed: () {
                    provider.markAllAsRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All notifications marked as read')),
                    );
                  },
                  child: const Text('Mark All'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: AppTheme.textLight,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'All notifications will appear here',
                    style: TextStyle(
                      color: AppTheme.textGray,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Unread notification banner
              if (provider.unreadCount > 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryBlue.withOpacity(0.1),
                        AppTheme.primaryBlue.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'You have ${provider.unreadCount} new notifications',
                        style: const TextStyle(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              // Notifications list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = provider.notifications[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: notification.isRead ? null : AppTheme.primaryBlue.withOpacity(0.05),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getNotificationColor(notification.type).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _getNotificationIcon(notification.type),
                            color: _getNotificationColor(notification.type),
                            size: 20,
                          ),
                        ),
                        title: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              notification.message,
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatTimestamp(notification.timestamp),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        trailing: notification.isRead 
                            ? null 
                            : Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                        onTap: () {
                          if (!notification.isRead) {
                            provider.markAsRead(notification.id);
                          }
                          _handleNotificationTap(context, notification);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'analysis':
        return Icons.analytics;
      case 'reminder':
        return Icons.schedule;
      case 'tip':
        return Icons.lightbulb;
      case 'update':
        return Icons.system_update;
      case 'consultation':
        return Icons.chat;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'analysis':
        return AppTheme.primaryBlue;
      case 'reminder':
        return AppTheme.secondaryOrange;
      case 'tip':
        return AppTheme.secondaryGreen;
      case 'update':
        return AppTheme.secondaryPurple;
      case 'consultation':
        return AppTheme.secondaryRed;
      default:
        return AppTheme.textGray;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, y').format(timestamp);
    }
  }

  void _handleNotificationTap(BuildContext context, notification) {
    // Handle different notification types
    switch (notification.type) {
      case 'analysis':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening analysis results...')),
        );
        break;
      case 'reminder':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening reminder details...')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening ${notification.type}...')),
        );
    }
  }
}