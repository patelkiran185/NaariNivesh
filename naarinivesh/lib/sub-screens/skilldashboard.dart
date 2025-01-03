import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class SkillDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Monetization'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Skill Monetization Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
    );
  }
}