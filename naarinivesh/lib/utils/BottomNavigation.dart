import 'package:flutter/material.dart';
import 'package:naarinivesh/screens/home.dart';
import 'package:naarinivesh/screens/invest.dart';
import 'package:naarinivesh/screens/learnmain.dart';
import 'package:naarinivesh/screens/mentor.dart';
import 'package:naarinivesh/screens/profile.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  BottomNavigation({required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InvestScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LearnmainScreen()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MentorScreen()));
        break;
      case 4:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Invest'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learn'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Mentor'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}