import 'package:flutter/material.dart';
import 'package:skincheck/utils/theme.dart';

class CancerTypesScreen extends StatefulWidget {
  const CancerTypesScreen({super.key});

  @override
  State<CancerTypesScreen> createState() => _CancerTypesScreenState();
}

class _CancerTypesScreenState extends State<CancerTypesScreen> {
  String _selectedType = 'basal';

  final Map<String, Map<String, dynamic>> _cancerTypes = {
    'basal': {
      'name': 'Basal Cell Carcinoma',
      'prevalence': '80%',
      'severity': 'Low',
      'color': AppTheme.secondaryGreen,
      'description': 'The most common type of skin cancer, usually appears on sun-exposed areas',
      'characteristics': [
        'Pearly or waxy bump',
        'Flat, flesh-colored or brown scar-like lesion',
        'Bleeding or scabbing sore that heals and returns'
      ],
      'locations': ['Face', 'Ears', 'Neck', 'Scalp', 'Shoulders', 'Back'],
      'prognosis': 'Excellent when caught early. Rarely spreads to other parts of the body.',
      'treatment': 'Surgical removal, Mohs surgery, radiation therapy, or topical medications'
    },
    'squamous': {
      'name': 'Squamous Cell Carcinoma',
      'prevalence': '16%',
      'severity': 'Medium',
      'color': AppTheme.secondaryOrange,
      'description': 'Second most common skin cancer, can spread if not treated',
      'characteristics': [
        'Firm, red nodule',
        'Flat lesion with scaly, crusted surface',
        'New sore or raised area on old scar'
      ],
      'locations': ['Face', 'Ears', 'Hands', 'Arms', 'Legs'],
      'prognosis': 'Good when detected early. Can spread to lymph nodes if left untreated.',
      'treatment': 'Surgical excision, Mohs surgery, radiation therapy, or cryotherapy'
    },
    'melanoma': {
      'name': 'Melanoma',
      'prevalence': '4%',
      'severity': 'High',
      'color': AppTheme.secondaryRed,
      'description': 'Most dangerous form of skin cancer, can spread rapidly',
      'characteristics': [
        'Asymmetrical mole',
        'Irregular borders',
        'Multiple colors',
        'Diameter larger than 6mm',
        'Evolving appearance'
      ],
      'locations': ['Back (men)', 'Legs (women)', 'Face', 'Neck', 'Arms'],
      'prognosis': 'Excellent if caught early (99% 5-year survival). Dangerous if it spreads.',
      'treatment': 'Wide surgical excision, lymph node biopsy, immunotherapy, targeted therapy'
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of Skin Cancer'),
        backgroundColor: AppTheme.secondaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Type Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: _cancerTypes.entries.map((entry) {
                    final key = entry.key;
                    final type = entry.value;
                    final isSelected = _selectedType == key;
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedType = key;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppTheme.secondaryGreen.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected 
                                  ? AppTheme.secondaryGreen 
                                  : AppTheme.backgroundGray,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      type['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textDark,
                                      ),
                                    ),
                                    Text(
                                      '${type['prevalence']} of all skin cancers',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getSeverityColor(type['severity']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${type['severity']} Risk',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getSeverityColor(type['severity']),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Detailed Information
            _buildDetailedInfo(),

            const SizedBox(height: 16),

            // Statistics
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Skin Cancer Statistics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  '5.4M',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                                Text(
                                  'Cases treated annually',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textGray,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  '99%',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.secondaryGreen,
                                  ),
                                ),
                                Text(
                                  'Survival rate when caught early',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textGray,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to scan screen
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text('Check Your Skin'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryGreen,
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

  Widget _buildDetailedInfo() {
    final currentType = _cancerTypes[_selectedType]!;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.info,
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
                        currentType['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Text(
                        currentType['description'],
                        style: const TextStyle(
                          color: AppTheme.textGray,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Characteristics
            const Text(
              'What to Look For:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 12),
            ...currentType['characteristics'].map<Widget>((char) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: AppTheme.secondaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      char,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),

            // Common Locations
            const Text(
              'Common Locations:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: currentType['locations'].map<Widget>((location) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textDark,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),

            // Prognosis
            const Text(
              'Prognosis:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentType['prognosis'],
              style: const TextStyle(
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),

            // Treatment
            const Text(
              'Treatment Options:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentType['treatment'],
              style: const TextStyle(
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Low':
        return AppTheme.secondaryGreen;
      case 'Medium':
        return AppTheme.secondaryOrange;
      case 'High':
        return AppTheme.secondaryRed;
      default:
        return AppTheme.textGray;
    }
  }
}