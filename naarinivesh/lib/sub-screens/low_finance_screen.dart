import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:confetti/confetti.dart';

class LowFinanceScreen extends StatefulWidget {
  const LowFinanceScreen({Key? key}) : super(key: key);

  @override
  _LowFinanceScreenState createState() => _LowFinanceScreenState();
}

class _LowFinanceScreenState extends State<LowFinanceScreen> with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late ConfettiController _confettiController;
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is a budget?',
      'options': [
        'A type of investment',
        'A plan for managing money',
        'A bank account',
        'A credit card'
      ],
      'correctAnswer': 1,
      'explanation': 'A budget is a plan for managing your money, tracking income and expenses.'
    },
    {
      'question': 'Which of these is a good saving habit?',
      'options': [
        'Spending all your money immediately',
        'Saving only when you have extra money',
        'Setting aside a portion of your income regularly',
        'Borrowing money to save'
      ],
      'correctAnswer': 2,
      'explanation': 'Regularly saving a portion of your income is a good financial habit.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _initializeTts();
  }

  void _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  void _speakText(String text) async {
    await flutterTts.speak(text);
  }

  void _checkAnswer(int selectedIndex) {
    bool isCorrect = selectedIndex == _questions[_currentQuestionIndex]['correctAnswer'];
    if (isCorrect) {
      setState(() => _score++);
      _confettiController.play();
    }
    _showFeedback(isCorrect);
  }

  void _showFeedback(bool isCorrect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
          title: Text(isCorrect ? '🎉 Correct!' : '❌ Incorrect',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          content: Text(_questions[_currentQuestionIndex]['explanation'],
              style: TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              child: const Text('Next Question', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                _nextQuestion();
              },
            ),
          ],
        );
      },
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() => _currentQuestionIndex++);
      _speakText(_questions[_currentQuestionIndex]['question']);
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('Quiz Completed! 🎯', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text('Your score: $_score / ${_questions.length}', style: TextStyle(fontSize: 20)),
          actions: [
            TextButton(
              child: const Text('Restart', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                });
                _speakText(_questions[_currentQuestionIndex]['question']);
              },
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
        title: const Text('Financial Quiz 💰', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _questions[_currentQuestionIndex]['question'],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ..._questions[_currentQuestionIndex]['options'].asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: Text(entry.value, style: const TextStyle(fontSize: 16)),
                                  onPressed: () => _checkAnswer(entry.key),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.teal.shade700),
                                onPressed: () => _speakText(entry.value),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Score: $_score / ${_questions.length}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    flutterTts.stop();
    super.dispose();
  }
}
