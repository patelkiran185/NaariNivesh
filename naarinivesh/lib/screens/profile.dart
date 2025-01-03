import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Profile Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 4),
    );
  }
}