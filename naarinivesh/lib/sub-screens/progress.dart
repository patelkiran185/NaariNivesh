import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Summary'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Progress Summary Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
    );
  }
}