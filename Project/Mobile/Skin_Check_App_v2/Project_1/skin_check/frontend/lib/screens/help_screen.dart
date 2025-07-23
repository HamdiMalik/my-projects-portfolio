import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
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
                _buildTabButton('FAQ', 0),
                _buildTabButton('Contact', 1),
                _buildTabButton('Resources', 2),
              ],
            ),
          ),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal : Colors.transparent,
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
        return _buildFAQTab();
      case 1:
        return _buildContactTab();
      case 2:
        return _buildResourcesTab();
      default:
        return _buildFAQTab();
    }
  }

  Widget _buildFAQTab() {
    final faqs = [
      {
        'question': 'How accurate is the skin scanning feature?',
        'answer': 'Our AI-powered skin scanning tool is designed to assist in early detection...',
      },
      {
        'question': 'How often should I check my skin?',
        'answer': 'Perform monthly self-examinations and have annual professional skin checks...',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.help_outline, color: Colors.teal, size: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faq['question'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        faq['answer'] as String,
                        style: const TextStyle(color: AppTheme.textGray, height: 1.5),
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

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildContactItem(
            icon: Icons.emergency,
            title: 'Emergency Services',
            subtitle: 'For immediate medical emergencies',
            contact: '911',
            color: AppTheme.secondaryRed,
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    final resources = [
      {
        'icon': Icons.video_library,
        'title': 'Video Tutorials',
        'description': 'Learn how to perform self-examinations',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return Card(
          child: ListTile(
            leading: Icon(resource['icon'] as IconData, color: Colors.teal),
            title: Text(resource['title'] as String),
            subtitle: Text(resource['description'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String contact,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
        Text(contact, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
