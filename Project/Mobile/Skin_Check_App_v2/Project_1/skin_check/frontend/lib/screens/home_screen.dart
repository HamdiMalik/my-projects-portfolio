import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';
import 'package:skincheck/screens/early_detection_screen.dart';
import 'package:skincheck/screens/prevention_tips_screen.dart';
import 'package:skincheck/screens/cancer_types_screen.dart';
import 'package:skincheck/screens/scan_screen.dart';
import 'package:skincheck/screens/history_screen.dart';
import 'package:skincheck/screens/help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  final List<InfoCard> _infoCards = [
    InfoCard(
      title: 'Early Detection\nSkin Cancer',
      subtitle: 'Learn to recognize early signs of skin cancer',
      color: Colors.orange[400]!,
      icon: Icons.visibility,
      screen: const EarlyDetectionScreen(),
    ),
    InfoCard(
      title: 'Regular\nCheck-ups',
      subtitle: 'Perform regular skin examinations',
      color: Colors.purple[400]!,
      icon: Icons.schedule,
      screen: const EarlyDetectionScreen(),
    ),
    InfoCard(
      title: 'Prevention\nTips',
      subtitle: 'How to protect skin from harmful exposure',
      color: Colors.blue[400]!,
      icon: Icons.shield,
      screen: const PreventionTipsScreen(),
    ),
    InfoCard(
      title: 'Types of\nSkin Cancer',
      subtitle: 'Learn about different types and their characteristics',
      color: Colors.green[400]!,
      icon: Icons.category,
      screen: const CancerTypesScreen(),
    ),
    InfoCard(
      title: 'Warning\nSigns',
      subtitle: 'Watch out for signs that need attention',
      color: Colors.red[400]!,
      icon: Icons.warning,
      screen: const EarlyDetectionScreen(),
    ),
  ];

  final List<PopularItem> _popularItems = [
    PopularItem(
      icon: Icons.favorite,
      label: 'Prevention',
      color: Colors.red[400]!,
      screen: const PreventionTipsScreen(),
    ),
    PopularItem(
      icon: Icons.medical_services,
      label: 'Check-up',
      color: Colors.blue[400]!,
      screen: const EarlyDetectionScreen(),
    ),
    PopularItem(
      icon: Icons.info,
      label: 'Information',
      color: Colors.orange[400]!,
      screen: const CancerTypesScreen(),
    ),
    PopularItem(
      icon: Icons.camera_alt,
      label: 'Scan',
      color: Colors.green[400]!,
      screen: const ScanScreen(),
    ),
    PopularItem(
      icon: Icons.history,
      label: 'History',
      color: Colors.purple[400]!,
      screen: const HistoryScreen(),
    ),
    PopularItem(
      icon: Icons.help,
      label: 'Help',
      color: Colors.teal[400]!,
      screen: const HelpScreen(),
    ),
  ];

  List<InfoCard> get _filteredCards {
    if (_searchQuery.isEmpty) return _infoCards;
    return _infoCards.where((card) {
      return card.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          card.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Information Title
          Text(
            'Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          
          SizedBox(height: 30),
          
          // Scrollable Information Cards
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filteredCards.length,
              padding: EdgeInsets.only(left: 5),
              itemBuilder: (context, index) {
                final card = _filteredCards[index];
                return _buildInfoCard(
                  title: card.title,
                  subtitle: card.subtitle,
                  color: card.color,
                  icon: card.icon,
                  screen: card.screen,
                );
              },
            ),
          ),
          
          SizedBox(height: 30),
          
          // Most Popular Section
          Text(
            'Most popular',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Popular Items Grid
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: _popularItems.map((item) => _buildPopularCard(
              icon: item.icon,
              label: item.label,
              color: item.color,
              screen: item.screen,
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        width: 280, // Fixed width untuk konsistensi
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCard({
    required IconData icon,
    required String label,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Widget screen;

  InfoCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.screen,
  });
}

class PopularItem {
  final IconData icon;
  final String label;
  final Color color;
  final Widget screen;

  PopularItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.screen,
  });
}