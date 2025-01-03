import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class InvestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invest'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Invest Screen Content'),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
    );
  }
}