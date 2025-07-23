import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:skincheck/providers/scan_provider.dart';
import 'package:skincheck/providers/auth_provider.dart';
import 'package:skincheck/utils/theme.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:skincheck/services/api_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isFlashOn = false;
  bool _isCapturing = false;
  String? _capturedImagePath;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras!.first,
          ResolutionPreset.high,
        );
        await _controller!.initialize();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to access camera. Please check permissions.'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (_controller != null) {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      await _controller!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile image = await _controller!.takePicture();
      setState(() {
        _capturedImagePath = image.path;
        _isCapturing = false;
      });
    } catch (e) {
      setState(() {
        _isCapturing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking picture: $e')),
        );
      }
    }
  }

  void _retakePicture() {
    setState(() {
      _capturedImagePath = null;
    });
  }

  Future<void> _analyzePicture() async {
    if (_capturedImagePath == null) return;
    
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Analyzing image...'),
          ],
        ),
      ),
    );

    try {
      // Call scan API with file path (no authentication required)
      final result = await ApiService.scanImage(_capturedImagePath!);
      
      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
      }
      
      if (result['success']) {
        final scanResult = result['result'];
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('🔬 Hasil Analisis!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Condition: ${scanResult['condition'] ?? 'Unknown'}'),
                  Text('Confidence: ${((scanResult['confidence'] ?? 0) * 100).toStringAsFixed(1)}%'),
                  if (scanResult['recommendations'] != null)
                    ...List<Widget>.from((scanResult['recommendations'] as List).map((r) => Text('- $r'))),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Kembali ke main screen
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['error'] ?? 'Gagal analisis gambar')),
          );
        }
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error analyzing image: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _capturedImagePath = pickedFile.path;
      });
      await _analyzePicture();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_capturedImagePath != null) {
      return _buildPreviewScreen();
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // UI Overlay
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),

                      // Title
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Skin Check',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Flash button
                      GestureDetector(
                        onTap: _toggleFlash,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isFlashOn 
                                ? AppTheme.primaryBlue 
                                : Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Scan guide overlay
                Expanded(
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.primaryBlue,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          // Corner brackets
                          Positioned(
                            top: -2,
                            left: -2,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Colors.white, width: 4),
                                  top: BorderSide(color: Colors.white, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white, width: 4),
                                  top: BorderSide(color: Colors.white, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            left: -2,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Colors.white, width: 4),
                                  bottom: BorderSide(color: Colors.white, width: 4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.white, width: 4),
                                  bottom: BorderSide(color: Colors.white, width: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Instructions
                Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return Text(
                        '📍 Position the affected area within the frame\n'
                        '💡 Ensure good lighting for better results\n'
                        '${authProvider.isAuthenticated ? '☁️ Results will sync to cloud' : '💾 Results saved locally'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),

                // Capture button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        label: Text('Kamera'),
                        onPressed: _takePicture,
                      ),
                      SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: Icon(Icons.photo_library),
                        label: Text('Galeri'),
                        onPressed: _pickImageFromGallery,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _retakePicture,
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Retake',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Photo Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 60),
                ],
              ),
            ),
          ),

          // Image preview
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(_capturedImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // Action buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Retake button
                      GestureDetector(
                        onTap: _retakePicture,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Retake',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Analyze button
                      GestureDetector(
                        onTap: _analyzePicture,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.analytics, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Analyze',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Offline indicator
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return Text(
                        authProvider.isAuthenticated 
                            ? '☁️ Results will be synced to cloud'
                            : '💾 Results will be saved locally',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}