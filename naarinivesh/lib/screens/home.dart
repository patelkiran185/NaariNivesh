import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';
import 'package:naarinivesh/sub-screens/finhealth.dart';
import 'package:naarinivesh/sub-screens/personalrecommend.dart';
import 'package:naarinivesh/sub-screens/progress.dart';
import 'package:naarinivesh/sub-screens/skilldashboard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome, Lakshmi'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 1.1, // Adjusted to prevent overflow
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCard(
                    context: context,
                    title: 'Skill Monetization',
                    value: '3 Skills',
                    subtitle: 'Potential earnings: ₹5000/month',
                    icon: Icons.work,
                    screen: SkillDashboardScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Personal Recommendation',
                    value: 'Start Saving',
                    subtitle: 'Set aside ₹100 weekly for emergencies',
                    icon: Icons.lightbulb,
                    screen: PersonalRecommendScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Financial Health',
                    value: 'Good',
                    subtitle: 'You\'ve saved ₹1000 this month!',
                    icon: Icons.favorite,
                    screen: FinHealthScreen(),
                  ),
                  _buildCard(
                    context: context,
                    title: 'Progress Summary',
                    value: '75%',
                    subtitle: 'Completed 3 out of 4 financial goals',
                    icon: Icons.trending_up,
                    screen: ProgressScreen(),
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
          padding: const EdgeInsets.all(12.0), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Added to prevent expansion
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13, // Slightly reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // Limit lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(icon, size: 20, color: Colors.teal), // Reduced icon size
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20, // Reduced font size
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Colors.grey), // Reduced font size
                maxLines: 2, // Limit lines
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}