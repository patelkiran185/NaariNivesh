// scenario_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:naarinivesh/constants.dart';

class ScenarioScreen extends StatefulWidget {
  final int level;

  const ScenarioScreen({Key? key, required this.level}) : super(key: key);

  @override
  _ScenarioScreenState createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  late Future<Map<String, dynamic>> _scenarioFuture;
  List<String> choices = [];
  String? selectedChoice;
  bool isLoading = false;
  String feedback = '';

  @override
  void initState() {
    super.initState();

    _scenarioFuture = _fetchScenario();
  }

  Future<Map<String, dynamic>> _fetchScenario() async {
    print(ip);
    final response = await http.get(
      Uri.parse('http://${ip}:5000/scenario/${widget.level}'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load scenario');
    }
  }

  Future<void> _submitChoice(String choice) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://${ip}:5000/evaluate'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'level': widget.level,
          'choice': choice,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          feedback = data['feedback'];
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade700, Colors.teal.shade900],
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _scenarioFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error loading scenario',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final scenario = snapshot.data!;

              return Column(
                children: [
                  // Character and dialog bubble
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        // Background scene
                        Positioned.fill(
                          child: Image.asset(
                            'assets/scenario_bg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Character
                        Positioned(
                          bottom: 0,
                          left: 20,
                          child: Image.asset(
                            'assets/character.png',
                            height: 200,
                          ),
                        ),
                        // Dialog bubble
                        Positioned(
                          top: 40,
                          left: 20,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Text(
                              scenario['scenario'],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Choices
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'What would you do?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: (scenario['choices'] as List).length,
                              itemBuilder: (context, index) {
                                final choice = scenario['choices'][index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => _submitChoice(choice),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal.shade50,
                                      padding: EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      choice,
                                      style: TextStyle(
                                        color: Colors.teal.shade900,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (feedback.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.teal.shade200,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  feedback,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.teal.shade900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          if (isLoading)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: CircularProgressIndicator(
                                color: Colors.teal.shade900,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
