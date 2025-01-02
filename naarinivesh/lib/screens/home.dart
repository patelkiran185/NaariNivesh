import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', textAlign: TextAlign.center,),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Remove the back arrow
        foregroundColor: Colors.white, 
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            HomeCard(
              title: 'Skill Monetization',
              icon: Icons.lightbulb_outline,
              color: Colors.teal,
              onTap: () {
                Navigator.pushNamed(context, '/skilldashboard');
              },
            ),
            HomeCard(
              title: 'Financial Health',
              icon: Icons.health_and_safety_outlined,
              color: Colors.purple,
              onTap: () {
                Navigator.pushNamed(context, '/finhealth');
              },
            ),
            HomeCard(
              title: 'Personal Recommendation',
              icon: Icons.recommend,
              color: Colors.amber, // Gold accent
              onTap: () {
                Navigator.pushNamed(context, '/personalrecommend');
              },
            ),
            HomeCard(
              title: 'Progress Summary',
              icon: Icons.bar_chart,
              color: Colors.teal,
              onTap: () {
                Navigator.pushNamed(context, '/progress');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeCard({super.key, required this.title, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}