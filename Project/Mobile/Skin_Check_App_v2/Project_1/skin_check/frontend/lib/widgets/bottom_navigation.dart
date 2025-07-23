import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Left Icon (Home)
          IconButton(
            icon: Icon(
              Icons.home,
              size: 32,
              color: currentIndex == 0 ? const Color(0xFF00A6FF) : Colors.grey,
            ),
            onPressed: () => onTabChanged(0),
          ),

          // Middle Icon (Scan)
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              size: 36, // Increased size for the scan icon
              color: currentIndex == 1 ? const Color(0xFF00A6FF) : Colors.grey,
            ),
            onPressed: () => onTabChanged(1),
          ),

          // Right Icon (Person)
          IconButton(
            icon: Icon(
              Icons.person,
              size: 32,
              color: currentIndex == 2 ? const Color(0xFF00A6FF) : Colors.grey,
            ),
            onPressed: () => onTabChanged(2),
          ),
        ],
      ),
    );
  }
}