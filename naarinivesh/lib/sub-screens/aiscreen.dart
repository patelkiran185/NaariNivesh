import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIScreen extends StatefulWidget {
  @override
  _AIScreenState createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "What is compound interest?",
      "difficulty": "Medium",
      "points": 10
    },
    // Add more questions
  ];

  int _currentQuestionIndex = 0;
  String _userResponse = "";
  String _feedback = "";
  int _score = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  Future<void> _evaluateAnswer() async {
  if (_userResponse.isEmpty) return;

  setState(() {
    _isLoading = true;
    _feedback = ""; 
  });

  try {
    final response = await http.post(
     Uri.parse('${dotenv.env['API_URL']}/evaluate'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'question': _questions[_currentQuestionIndex]['question'],
        'answer': _userResponse,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        int receivedScore = (data['points'] as int?) ?? 0;
        _score += receivedScore;
        _feedback = "Your answer scored: $receivedScore/10"; 
      });
    } else {
      setState(() {
        _feedback = "Failed to evaluate. Try again!";
      });
    }
  } catch (e) {
    setState(() {
      _feedback = "Error: Unable to connect to the server.";
    });
  } finally {
    setState(() => _isLoading = false);
  }
}


  void _nextQuestion() async {
    await _evaluateAnswer();
    
    if (_currentQuestionIndex < _questions.length - 1) {
      _animationController.reset();
      setState(() {
        _currentQuestionIndex++;
        _userResponse = "";
        _feedback = "";
      });
      _animationController.forward();
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal.shade50,
        title: Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.celebration, size: 50, color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'Your Score: $_score',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          'Finance Quiz',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Score: $_score',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${_currentQuestionIndex + 1}',
                          style: GoogleFonts.poppins(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _questions[_currentQuestionIndex]['question'],
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Difficulty: ${_questions[_currentQuestionIndex]['difficulty']}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            TextField(
              onChanged: (value) => setState(() => _userResponse = value),
              decoration: InputDecoration(
                hintText: 'Your answer',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.teal))
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _userResponse.isNotEmpty ? _evaluateAnswer : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Submit Answer',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      if (_feedback.isNotEmpty)
                        Text(
                          _feedback,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
