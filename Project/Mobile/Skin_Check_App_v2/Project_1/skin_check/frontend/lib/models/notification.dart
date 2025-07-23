class AppNotification {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime timestamp;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'].toString(),
      title: json['title'],
      message: json['message'],
      type: json['type'],
      isRead: json['is_read'] ?? false,
      timestamp: DateTime.parse(json['timestamp'] ?? json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'is_read': isRead,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}