import 'package:flutter/material.dart';
import 'package:skincheck/screens/home_screen.dart';
import 'package:skincheck/screens/scan_screen.dart';
import 'package:skincheck/screens/profile_screen.dart';
import 'package:skincheck/widgets/bottom_navigation.dart';
import 'package:skincheck/widgets/top_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScanScreen(),
    const ProfileScreen(),
  ];

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopNavigation(),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}