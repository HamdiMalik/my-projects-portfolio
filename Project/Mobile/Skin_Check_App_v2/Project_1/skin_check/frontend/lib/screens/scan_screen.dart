import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';
import 'package:skincheck/screens/camera_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rippleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleCameraPress() {
    setState(() {
      _isAnimating = true;
    });

    // Navigate to camera screen after animation
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CameraScreen()),
        ).then((_) {
          setState(() {
            _isAnimating = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background biru atas
          Container(
            height: size.height,
            color: const Color(0xFF33B8FF),
          ),

          // Latar putih melengkung
          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: size.height * 0.75,
                color: Colors.white,
              ),
            ),
          ),

          // Ripple effect circles
          Positioned(
            top: size.height * 0.15,
            child: AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ripple 1
                    if (_rippleAnimation.value > 0.1 && !_isAnimating)
                      Container(
                        width: 200 + (_rippleAnimation.value * 30),
                        height: 200 + (_rippleAnimation.value * 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF00A6FF).withOpacity(
                              (1.0 - _rippleAnimation.value) * 0.3,
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    // Ripple 2
                    if (_rippleAnimation.value > 0.3 && !_isAnimating)
                      Container(
                        width: 200 + ((_rippleAnimation.value - 0.2) * 50),
                        height: 200 + ((_rippleAnimation.value - 0.2) * 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF00A6FF).withOpacity(
                              (1.0 - _rippleAnimation.value) * 0.2,
                            ),
                            width: 1,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          // Lingkaran besar dengan icon kamera di tengah
          Positioned(
            top: size.height * 0.15,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isAnimating ? _scaleAnimation.value : _pulseAnimation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00A6FF).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: _handleCameraPress,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF00A6FF),
                                Color(0xFF0088CC),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: const Color.fromARGB(255, 143, 216, 255),
                              width: 20,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00A6FF).withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Scan instruction text
          Positioned(
            bottom: size.height * 0.15,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00A6FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFF00A6FF).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    '📸 Tap to scan your skin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00A6FF),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Position the affected area in good lighting',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 80);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}