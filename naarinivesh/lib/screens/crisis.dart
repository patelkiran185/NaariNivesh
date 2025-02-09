import 'package:flutter/material.dart';

class CrisisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crisis Readiness'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressSection(),
              const SizedBox(height: 24),
              _buildLevelsGrid(context),
              const SizedBox(height: 24),
              _buildRecommendationsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Crisis Readiness',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.shield, color: Colors.teal),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level 3/5 Complete',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                '60% Protected',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelsGrid(BuildContext context) {
    final levels = [
      {
        'title': 'Basic Emergency',
        'subtitle': 'Build a 1-month safety net',
        'icon': Icons.savings,
        'completed': true,
        'amount': '₹10,000',
      },
      {
        'title': 'Health Crisis',
        'subtitle': 'Medical emergency fund',
        'icon': Icons.local_hospital,
        'completed': true,
        'amount': '₹50,000',
      },
      {
        'title': 'Job Loss',
        'subtitle': '3-month expense buffer',
        'icon': Icons.work_off,
        'completed': true,
        'amount': '₹1,00,000',
      },
      {
        'title': 'Family Emergency',
        'subtitle': 'Extended support fund',
        'icon': Icons.family_restroom,
        'completed': false,
        'amount': '₹2,00,000',
      },
      {
        'title': 'Natural Disaster',
        'subtitle': 'Asset protection plan',
        'icon': Icons.warning,
        'completed': false,
        'amount': '₹5,00,000',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Emergency Levels',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: levels.length,
          itemBuilder: (context, index) {
            final level = levels[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: level['completed'] as bool
                        ? Colors.teal.withOpacity(0.1)
                        : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    level['icon'] as IconData,
                    color: level['completed'] as bool
                        ? Colors.redAccent
                        : Colors.grey,
                  ),
                ),
                title: Text(
                  level['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '${level['subtitle']}\nTarget: ${level['amount']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: level['completed'] as bool
                    ? const Icon(Icons.check_circle,
                        color: Colors.green, size: 20)
                    : const Icon(Icons.lock, color: Colors.grey, size: 20),
                onTap: () => _showLevelDetails(context, level),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecommendationsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AI Recommendations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.auto_awesome, color: Colors.redAccent),
              ],
            ),
            const SizedBox(height: 16),
            _buildRecommendationItem(
              'Health Insurance',
              'Coverage: ₹5L | Premium: ₹12K/year',
              Icons.health_and_safety,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              'Emergency Fund',
              'Save ₹2,000/month in high-yield account',
              Icons.savings,
            ),
            const SizedBox(height: 12),
            _buildRecommendationItem(
              'Term Insurance',
              'Coverage: ₹50L | Premium: ₹15K/year',
              Icons.security,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.redAccent, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLevelDetails(BuildContext context, Map<String, dynamic> level) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              level['title'] as String,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Target Amount: ${level["amount"]}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Recommended Actions:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Set up automatic monthly savings'),
              dense: true,
            ),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Review and optimize monthly expenses'),
              dense: true,
            ),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text('Research suitable insurance options'),
              dense: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Start This Level',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}