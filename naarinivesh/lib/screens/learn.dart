import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Learn Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 1),
    );
  }
}