import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';

class EarlyDetectionScreen extends StatelessWidget {
  const EarlyDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Early Detection'),
        backgroundColor: AppTheme.secondaryOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.visibility,
                        color: AppTheme.secondaryOrange,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Why Early Detection Matters',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'When skin cancer is detected early, the 5-year survival rate is over 99%. Regular self-examinations and knowing what to look for can save your life.',
                            style: TextStyle(
                              color: AppTheme.textGray,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ABCDE Rule
            const Text(
              'The ABCDE Rule',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Use this simple guide to check your moles:',
              style: TextStyle(
                color: AppTheme.textGray,
              ),
            ),
            const SizedBox(height: 16),
            ..._buildABCDERules(),

            const SizedBox(height: 32),

            // Warning Signs
            const Text(
              'Additional Warning Signs',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            ..._buildWarningSignsCards(),

            const SizedBox(height: 32),

            // Self-Examination Guide
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly Self-Examination',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._buildSelfExamSteps(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Action Button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Navigate to scan screen
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Start Skin Scan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildABCDERules() {
    final rules = [
      {
        'letter': 'A',
        'term': 'Asymmetry',
        'description': 'One half of the mole does not match the other half',
        'example': 'Draw an imaginary line through the middle - both sides should look similar',
      },
      {
        'letter': 'B',
        'term': 'Border',
        'description': 'Edges are irregular, ragged, notched, or blurred',
        'example': 'Healthy moles have smooth, even borders',
      },
      {
        'letter': 'C',
        'term': 'Color',
        'description': 'Color is not uniform throughout',
        'example': 'Watch for multiple colors: brown, black, red, white, or blue',
      },
      {
        'letter': 'D',
        'term': 'Diameter',
        'description': 'Larger than 6mm (about the size of a pencil eraser)',
        'example': 'Though melanomas can be smaller when first detected',
      },
      {
        'letter': 'E',
        'term': 'Evolving',
        'description': 'Changes in size, shape, color, elevation, or symptoms',
        'example': 'New itching, bleeding, or crusting',
      },
    ];

    return rules.map((rule) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppTheme.secondaryOrange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    rule['letter'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rule['term'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rule['description'] as String,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rule['example'] as String,
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
      ),
    )).toList();
  }

  List<Widget> _buildWarningSignsCards() {
    final signs = [
      {
        'title': 'New Growth',
        'description': 'Any new mole or growth that appears after age 30',
        'icon': Icons.warning,
        'color': AppTheme.secondaryRed,
      },
      {
        'title': 'Changing Mole',
        'description': 'Existing mole that changes in size, shape, or color',
        'icon': Icons.visibility,
        'color': AppTheme.secondaryOrange,
      },
      {
        'title': 'Unusual Symptoms',
        'description': 'Itching, bleeding, crusting, or pain in a mole',
        'icon': Icons.warning,
        'color': AppTheme.secondaryRed,
      },
    ];

    return signs.map((sign) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (sign['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  sign['icon'] as IconData,
                  color: sign['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sign['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sign['description'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )).toList();
  }

  List<Widget> _buildSelfExamSteps() {
    final steps = [
      'Examine your body in a full-length mirror, front and back',
      'Check your underarms, forearms, and palms',
      'Examine your legs, including soles and between toes',
      'Use a hand mirror to check your neck and scalp',
    ];

    return steps.asMap().entries.map((entry) {
      final index = entry.key;
      final step = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppTheme.secondaryGreen,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                step,
                style: const TextStyle(
                  color: AppTheme.textDark,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
