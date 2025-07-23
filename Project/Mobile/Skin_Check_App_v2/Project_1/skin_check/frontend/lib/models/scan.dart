class Scan {
  final String id;
  final String imagePath;
  final ScanResult? result;
  final DateTime timestamp;
  final bool synced;

  Scan({
    required this.id,
    required this.imagePath,
    this.result,
    required this.timestamp,
    required this.synced,
  });

  factory Scan.fromJson(Map<String, dynamic> json) {
    return Scan(
      id: json['id'].toString(),
      imagePath: json['image_path'] ?? '',
      result: json['result'] != null ? ScanResult.fromJson(json['result']) : null,
      timestamp: DateTime.parse(json['timestamp'] ?? json['created_at']),
      synced: json['synced'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'result': result?.toJson(),
      'timestamp': timestamp.toIso8601String(),
      'synced': synced,
    };
  }
}

class ScanResult {
  final String condition;
  final double confidence;
  final List<String> recommendations;

  ScanResult({
    required this.condition,
    required this.confidence,
    required this.recommendations,
  });

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      condition: json['condition'] ?? 'Unknown',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      recommendations: List<String>.from(json['recommendations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition,
      'confidence': confidence,
      'recommendations': recommendations,
    };
  }
}