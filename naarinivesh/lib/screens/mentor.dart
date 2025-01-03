import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  final List<MentorCard> mentors = [
    MentorCard(
      name: 'Mentor 1',
      description: 'Empowering women in finance and investment.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 2',
      description: 'Expert in personal finance management for women.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 3',
      description: 'Specialist in stock market investments for women.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 4',
      description: 'Advisor for women\'s retirement planning.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 5',
      description: 'Consultant for women in real estate investments.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 6',
      description: 'Expert in mutual funds and SIPs for women.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 7',
      description: 'Financial advisor for women\'s tax planning.',
      imageUrl: 'assets/images/profile.png',
    ),
    MentorCard(
      name: 'Mentor 8',
      description: 'Specialist in cryptocurrency investments for women.',
      imageUrl: 'assets/images/profile.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor', textAlign: TextAlign.center),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Swiper(
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    mentors[index].imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                // Mentor Name
                Text(
                  mentors[index].name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                // Mentor Description
                Text(
                  mentors[index].description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                // Action Buttons
              // Action Buttons
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Expanded(
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white, // Set icon and text color to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
    ),
    onPressed: () {
      // Navigate to Mentor's profile
    },
    icon: const Icon(Icons.person, size: 20), // Adjust icon size
    label: const Text('Profile', style: TextStyle(fontSize: 16)), // Adjust text size
  ),
),
    SizedBox(width: 8), // Add spacing between buttons
    Expanded(
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.teal),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
        ),
        onPressed: () {
          // Connect with Mentor
        },
        icon: const Icon(Icons.message, color: Colors.teal, size: 20), // Adjust icon size
        label: const Text(
          'Connect',
          style: TextStyle(color: Colors.teal, fontSize: 16), // Adjust text size
        ),
      ),
    ),
  ],
),

              ],
            ),
          ),
        ),
        itemCount: mentors.length,
        itemWidth: MediaQuery.of(context).size.width * 0.8,
        itemHeight: MediaQuery.of(context).size.height * 0.65,
        layout: SwiperLayout.STACK,
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 3),
    );
  }
}

class MentorCard {
  final String name;
  final String description;
  final String imageUrl;

  MentorCard({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}
