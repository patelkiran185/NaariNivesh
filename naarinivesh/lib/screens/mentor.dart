import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class MentorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Mentor Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 3),
    );
  }
}