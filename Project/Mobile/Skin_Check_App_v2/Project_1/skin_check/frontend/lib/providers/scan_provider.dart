import 'package:flutter/material.dart';
import 'package:skincheck/models/scan.dart';
import 'package:skincheck/services/api_service.dart';
import 'package:skincheck/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class ScanProvider with ChangeNotifier {
  List<Scan> _scans = [];
  bool _isLoading = false;

  List<Scan> get scans => _scans;
  bool get isLoading => _isLoading;

  ScanProvider() {
    _loadCachedScans();
  }

  Future<void> _loadCachedScans() async {
    _scans = await StorageService.getScans();
    notifyListeners();
  }

  Future<Map<String, dynamic>> createScan({
    required String imagePath,
    ScanResult? result,
  }) async {
    try {
      // Create scan object
      final scan = Scan(
        id: const Uuid().v4(),
        imagePath: imagePath,
        result: result ?? _generateMockResult(),
        timestamp: DateTime.now(),
        synced: false, // Will be synced later if user is logged in
      );

      // Save to local storage
      await StorageService.addScan(scan);
      _scans.insert(0, scan);
      notifyListeners();

      // Try to sync to server if user is logged in
      final token = await StorageService.getToken();
      if (token != null && token.isNotEmpty) {
        try {
          final apiResult = await ApiService.createScan({
            'imagePath': imagePath,
            'result': result?.toJson(),
            'timestamp': scan.timestamp.toIso8601String(),
          });

          if (apiResult['success']) {
            // Update scan with server ID and mark as synced
            final updatedScan = Scan(
              id: apiResult['data']['scan']['id'].toString(),
              imagePath: scan.imagePath,
              result: scan.result,
              timestamp: scan.timestamp,
              synced: true,
            );

            // Update in local storage
            final index = _scans.indexWhere((s) => s.id == scan.id);
            if (index != -1) {
              _scans[index] = updatedScan;
              await StorageService.saveScans(_scans);
              notifyListeners();
            }
          } else if (apiResult['error']?.contains('Authentication required') == true) {
            // Token expired, keep scan as unsynced
            print('Authentication required for scan sync');
          }
        } catch (e) {
          print('Failed to sync scan to server: $e');
        }
      }

      return {'success': true, 'scan': scan};
    } catch (e) {
      return {'success': false, 'error': 'Failed to create scan: $e'};
    }
  }

  Future<void> syncScans() async {
    final unsyncedScans = _scans.where((scan) => !scan.synced).toList();
    
    if (unsyncedScans.isEmpty) return;

    try {
      final scansData = unsyncedScans.map((scan) => scan.toJson()).toList();
      final result = await ApiService.syncScans(scansData);

      if (result['success']) {
        // Mark all scans as synced
        _scans = _scans.map((scan) {
          return Scan(
            id: scan.id,
            imagePath: scan.imagePath,
            result: scan.result,
            timestamp: scan.timestamp,
            synced: true,
          );
        }).toList();

        await StorageService.saveScans(_scans);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to sync scans: $e');
    }
  }

  Future<void> loadScansFromServer() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.getScans();
      
      if (result['success']) {
        final serverScans = (result['data']['scans'] as List)
            .map((json) => Scan.fromJson(json))
            .toList();

        // Merge with local scans
        final allScans = <Scan>[...serverScans];
        
        // Add local unsynced scans
        final unsyncedScans = _scans.where((scan) => !scan.synced).toList();
        allScans.addAll(unsyncedScans);

        // Sort by timestamp
        allScans.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        _scans = allScans;
        await StorageService.saveScans(_scans);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to load scans from server: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  ScanResult _generateMockResult() {
    final conditions = [
      'Benign Mole',
      'Normal Skin',
      'Freckle',
      'Age Spot',
      'Seborrheic Keratosis'
    ];

    final recommendations = [
      ['Monitor for changes', 'Annual check-up recommended'],
      ['Continue regular self-examinations', 'Use sunscreen daily'],
      ['Protect from sun exposure', 'Monthly self-check'],
      ['No immediate action needed', 'Regular dermatologist visits'],
      ['Schedule dermatologist appointment', 'Monitor for growth or changes']
    ];

    final index = DateTime.now().millisecond % conditions.length;
    final confidence = 0.7 + (DateTime.now().millisecond % 25) / 100;

    return ScanResult(
      condition: conditions[index],
      confidence: confidence,
      recommendations: recommendations[index],
    );
  }

  int get unsyncedCount => _scans.where((scan) => !scan.synced).length;
}