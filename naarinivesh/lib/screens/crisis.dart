import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naarinivesh/constants.dart';
import 'dart:convert';
class CrisisScreen extends StatelessWidget {
  CrisisScreen({Key? key}) : super(key: key);

  final Map<String, int> levelMapping = {
      'Basic Emergency': 1,
      'Health Crisis': 2,
      'Job Loss': 3,
      'Family Emergency': 4,
      'Natural Disaster': 5,
    };

  Future<void> _sendLevelToBackend(BuildContext context, String level) async {
    // Get the corresponding level number
    final levelNumber = levelMapping[level];
    if (levelNumber == null) {
      print('Invalid level: $level');
      return;
    }

    final url = Uri.parse('http://${ip}:5000/scenario/$levelNumber');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Level started: $level');
        final responseData = jsonDecode(response.body) as Map<String, dynamic>; // Cast to Map<String, dynamic>
        print('Response: $responseData');
        
        // Pass both level and response data
        Navigator.pushNamed(
          context,
          '/scenario',
          arguments: {
            'level': levelNumber, // Pass the level number
            ...responseData, // Spread the response data
          },
        );
      } else {
        print('Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Failed to connect: $e');
    }
}

  void _showPopup(BuildContext context, String level) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start this level?'),
          content: Text('Do you want to start $level?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _sendLevelToBackend(context, level);  // Pass context here
              },
              child: Text('Start'),
            ),
          ],
        );
      },
    );
  }

  void _showStartSimulationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Welcome!'),
          content: Text('Start your simulation today!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Let\'s Begin!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crisis Readiness Roadmap'),
        backgroundColor: Colors.teal,
      ),
      body: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(0),
        minScale: 1.0,
        maxScale: 3.0,
        child: Container(
          width: MediaQuery.of(context).size.width * 2, // Make image wider
          height: MediaQuery.of(context).size.height * 2, // Make image taller
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/roadmap.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              
              // Invisible clickable areas
              Stack(
                children: [
                  // Basic Emergency (far left lower mid)
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.3,
                    left: 20,
                    child: _buildClickableArea(
                      context,
                      'Basic Emergency',
                    ),
                  ),
                  
                  // Health Crisis (far left upper mid)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    left: 20,
                    child: _buildClickableArea(
                      context,
                      'Health Crisis',
                    ),
                  ),
                  
                  // Financial Debt (top center)
                  Positioned(
                    top: 50,
                    left: MediaQuery.of(context).size.width / 2 - 75,
                    child: _buildClickableArea(
                      context,
                      'Financial Debt',
                    ),
                  ),
                  
                  // Job Loss (center)
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 75,
                    left: MediaQuery.of(context).size.width / 2 - 75,
                    child: _buildClickableArea(
                      context,
                      'Job Loss',
                    ),
                  ),
                  
                  // Family Emergency (far right middle)
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 75,
                    right: 20,
                    child: _buildClickableArea(
                      context,
                      'Family Emergency',
                    ),
                  ),
                  
                  // Natural Disaster (bottom right)
                  Positioned(
                    bottom: 50,
                    right: 20,
                    child: _buildClickableArea(
                      context,
                      'Natural Disaster',
                    ),
                  ),
                  
                  // Start Simulation (bottom left)
                  Positioned(
                    bottom: 50,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => _showStartSimulationPopup(context),
                      child: Container(
                        width: 150,
                        height: 150,
                        color: Colors.transparent,
                        // Uncomment for debugging
                        // color: Colors.red.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClickableArea(BuildContext context, String level) {
    return GestureDetector(
      onTap: () => _showPopup(context, level),
      child: Container(
        width: 150,  // Larger clickable area
        height: 150, // Larger clickable area
        color: Colors.transparent, // Invisible hit box
        // Uncomment below during development to see clickable areas
        // color: Colors.red.withOpacity(0.3), // For debugging
      ),
    );
  }
}