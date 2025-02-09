import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';
import 'learn.dart';
import 'crisis.dart';

class LearnmainScreen extends StatelessWidget {
  const LearnmainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Naari Shiksha'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Learning Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore our educational resources tailored for you',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 1.1,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCard(
                    context: context,
                    title: 'Financial Basics',
                    value: '6 Modules',
                    subtitle: 'Start with savings & budgeting basics',
                    icon: Icons.account_balance_wallet,
                    screen: LearnScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Investment Guide',
                    value: '4 Modules',
                    subtitle: 'Learn safe investment strategies',
                    icon: Icons.trending_up,
                    screen: LearnScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Crisis Planning',
                    value: '3 Modules',
                    subtitle: 'Build your emergency fund strategy',
                    icon: Icons.shield,
                    screen: CrisisScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Digital Banking',
                    value: '5 Modules',
                    subtitle: 'Master online financial tools',
                    icon: Icons.phone_android,
                    screen: LearnScreen(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(icon, size: 20, color: Colors.teal),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}