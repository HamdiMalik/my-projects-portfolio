import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';

class PreventionTipsScreen extends StatefulWidget {
  const PreventionTipsScreen({super.key});

  @override
  State<PreventionTipsScreen> createState() => _PreventionTipsScreenState();
}

class _PreventionTipsScreenState extends State<PreventionTipsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prevention Tips'),
        backgroundColor: AppTheme.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton('Daily Protection', 0),
                _buildTabButton('Lifestyle Tips', 1),
                _buildTabButton('Sunscreen Guide', 2),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppTheme.textGray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildDailyProtectionTab();
      case 1:
        return _buildLifestyleTipsTab();
      case 2:
        return _buildSunscreenGuideTab();
      default:
        return _buildDailyProtectionTab();
    }
  }

  Widget _buildDailyProtectionTab() {
    final tips = [
      {
        'icon': Icons.wb_sunny,
        'title': 'Use Sunscreen Daily',
        'description': 'Apply broad-spectrum SPF 30+ sunscreen 30 minutes before going outside',
        'details': 'Reapply every 2 hours and after swimming or sweating',
      },
      {
        'icon': Icons.checkroom,
        'title': 'Wear Protective Clothing',
        'description': 'Long sleeves, pants, and wide-brimmed hats provide excellent protection',
        'details': 'Look for clothing with UPF (Ultraviolet Protection Factor) ratings',
      },
      {
        'icon': Icons.visibility,
        'title': 'Seek Shade',
        'description': 'Stay in shade during peak UV hours (10 AM - 4 PM)',
        'details': 'UV rays are strongest during midday hours',
      },
      {
        'icon': Icons.shield,
        'title': 'Avoid Tanning Beds',
        'description': 'Tanning beds increase melanoma risk by 75% for first-time users under 35',
        'details': 'No amount of indoor tanning is considered safe',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tip['icon'] as IconData,
                    color: AppTheme.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip['title']!as String,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip['description']!as String,
                        style: const TextStyle(
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip['details']!as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textGray,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLifestyleTipsTab() {
    final tips = [
      {
        'icon': Icons.water_drop,
        'title': 'Stay Hydrated',
        'description': 'Proper hydration helps maintain healthy skin barrier function',
        'details': 'Drink at least 8 glasses of water daily',
      },
      {
        'icon': Icons.restaurant,
        'title': 'Eat Antioxidant-Rich Foods',
        'description': 'Foods high in vitamins C, E, and beta-carotene protect against UV damage',
        'details': 'Include berries, leafy greens, and colorful vegetables',
      },
      {
        'icon': Icons.schedule,
        'title': 'Regular Skin Checks',
        'description': 'Perform monthly self-examinations and annual dermatologist visits',
        'details': 'Early detection saves lives',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    tip['icon'] as IconData,
                    color: AppTheme.secondaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip['title']!as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip['description']!as String,
                        style: const TextStyle(
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tip['details']!as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textGray,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSunscreenGuideTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // SPF Protection Levels
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SPF Protection Levels',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildSPFLevels(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Application Tips
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Application Tips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildApplicationTips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSPFLevels() {
    final levels = [
      {'spf': 'SPF 15', 'protection': '93%', 'recommendation': 'Minimum for daily use'},
      {'spf': 'SPF 30', 'protection': '97%', 'recommendation': 'Recommended for most people'},
      {'spf': 'SPF 50', 'protection': '98%', 'recommendation': 'For extended outdoor activities'},
      {'spf': 'SPF 100', 'protection': '99%', 'recommendation': 'For very fair skin or high-risk situations'},
    ];

    return levels.map((level) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.backgroundGray),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level['spf']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                level['recommendation']!,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textGray,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                level['protection']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
              const Text(
                'UV Protection',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textGray,
                ),
              ),
            ],
          ),
        ],
      ),
    )).toList();
  }

  List<Widget> _buildApplicationTips() {
    final tips = [
      'Use 1 ounce (2 tablespoons) for your entire body',
      'Apply 30 minutes before sun exposure',
      'Reapply every 2 hours or after swimming/sweating',
      'Don\'t forget ears, lips, and tops of feet',
    ];

    return tips.map((tip) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: AppTheme.primaryBlue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                color: AppTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    )).toList();
  }
}