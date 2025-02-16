import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sub-screens/aiscreen.dart';
import '../utils/BottomNavigation.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final FlutterTts flutterTts = FlutterTts();
  late ConfettiController _confettiController;
  int _coins = 0;
  int _hearts = 5;
  int _streak = 0;
  DateTime? _lastStreakDate;

  final List<Map<String, dynamic>> units = [
    {
      'title': 'Unit 1: Basics',
      'subtitle': 'Learn fundamental financial concepts',
      'icon': Icons.school,
      'progress': 0.3,
      'modules': [
        {'title': 'Budget Basics', 'completed': true},
        {'title': 'Saving Fundamentals', 'completed': true},
        {'title': 'Understanding Debt', 'completed': false},
        {'title': 'Banking 101', 'completed': false},
        {'title': 'Credit Basics', 'completed': false},
      ]
    },
    {
      'title': 'Unit 2: Savings',
      'subtitle': 'Master saving strategies',
      'icon': Icons.savings,
      'progress': 0.0,
      'modules': [
        {'title': 'Emergency Fund', 'completed': false},
        {'title': 'Savings Goals', 'completed': false},
        {'title': 'Interest Rates', 'completed': false},
        {'title': 'Savings Accounts', 'completed': false},
        {'title': 'Automated Saving', 'completed': false},
      ]
    },
    {
      'title': 'Unit 3: Investments',
      'subtitle': 'Understand investment basics',
      'icon': Icons.trending_up,
      'progress': 0.0,
      'modules': [
        {'title': 'Stock Market Basics', 'completed': false},
        {'title': 'Mutual Funds', 'completed': false},
        {'title': 'Risk Management', 'completed': false},
        {'title': 'Portfolio Building', 'completed': false},
        {'title': 'Investment Strategy', 'completed': false},
      ]
    },
    // Additional units from the original list...
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _loadStreak();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _streak = prefs.getInt('streak') ?? 0;
      _lastStreakDate = DateTime.tryParse(prefs.getString('lastStreakDate') ?? '');
      _updateStreak();
    });
  }

  void _updateStreak() {
    final now = DateTime.now();
    if (_lastStreakDate == null) {
      _lastStreakDate = now;
    } else {
      final difference = now.difference(_lastStreakDate!).inDays;
      if (difference > 1) {
        _streak = 0;
      } else if (difference == 1) {
        _streak++;
      }
    }
    _saveStreak();
  }

  Future<void> _saveStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', _streak);
    await prefs.setString('lastStreakDate', DateTime.now().toIso8601String());
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void _showSuccessDialog(bool isUnitComplete) {
    setState(() {
      if (isUnitComplete) {
        _coins += 50;
      } else {
        _coins += 10;
      }
      _updateStreak();
    });
    _confettiController.play();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal.shade50,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
            const Icon(Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 16),
            const Text(
              'Great job!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('You earned ${isUnitComplete ? 50 : 10} coins!'),
            Text('Daily Streak: $_streak'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Continue'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
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
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: AnimationLimiter(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        ...units.map((unit) => _buildUnitCard(
                          unit['title'],
                          unit['subtitle'],
                          unit['icon'],
                          unit['progress'],
                          unit['modules'],
                        )).toList(),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AIScreen(),
                              ),
                            );
                          },
                          child: const Text('Take AI Powered Quiz'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.quiz),
        onPressed: () => _startQuiz(context),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 1), 
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                '$_hearts',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                '$_coins',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.orange),
              const SizedBox(width: 4),
              Text(
                '$_streak',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnitCard(String title, String subtitle, IconData icon, double progress, List<Map<String, dynamic>> modules) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showModuleCircles(title, modules),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.teal, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModuleCircles(String unitTitle, List<Map<String, dynamic>> modules) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModuleCirclesScreen(
          unitTitle: unitTitle,
          modules: modules,
          onModuleComplete: _showSuccessDialog,
        ),
      ),
    );
  }

  void _startQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          onSuccess: () => _showSuccessDialog(false),
          onFailure: () {
            setState(() {
              _hearts = (_hearts - 1).clamp(0, 5);
            });
          },
        ),
      ),
    );
  }
}


class ModuleCirclesScreen extends StatelessWidget {
   final String unitTitle;
  final List<Map<String, dynamic>> modules;
  final Function(bool) onModuleComplete;

  const ModuleCirclesScreen({
    Key? key,
    required this.unitTitle,
    required this.modules,
    required this.onModuleComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(unitTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ConnectedLearningPath(
          modules: modules,
          onModuleTap: (module) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonScreen(
                  onSuccess: () => onModuleComplete(false),
                  onFailure: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildModuleCircle(BuildContext context, Map<String, dynamic> module, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonScreen(
              onSuccess: () => onModuleComplete(false),
              onFailure: () {},
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: module['completed'] ? Colors.teal : Colors.white,
          border: Border.all(color: Colors.teal, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              module['completed'] ? Icons.check_circle : Icons.play_circle_fill,
              color: module['completed'] ? Colors.white : Colors.teal,
              size: 32,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                module['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: module['completed'] ? Colors.white : Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Lesson ${index + 1}',
              style: TextStyle(
                color: module['completed'] ? Colors.white70 : Colors.teal.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const LessonScreen({
    Key? key,
    required this.onSuccess,
    required this.onFailure,
  }) : super(key: key);

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final PageController _pageController = PageController();
  final FlutterTts flutterTts = FlutterTts();
  
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is a Budget?',
      'answer': 'A financial plan for managing income and expenses',
      'options': [
        'A financial plan for managing income and expenses',
        'A type of investment',
        'A bank account',
        'A credit card'
      ],
    },
    {
      'question': 'What is Saving?',
      'answer': 'Setting aside money for future use',
      'options': [
        'Setting aside money for future use',
        'Spending all your money',
        'Taking out a loan',
        'Paying bills'
      ],
    },
  ];

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Practice Lesson'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return _buildQuestionCard(_questions[index]);
        },
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () => _speak(question['question']),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...question['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AnimatedButton(
                  text: option,
                  onPressed: () {
                    if (option == question['answer']) {
                      widget.onSuccess();
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      widget.onFailure();
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}


class QuizScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const QuizScreen({
    Key? key,
    required this.onSuccess,
    required this.onFailure,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _allQuestions = [
    {
      'question': 'What is compound interest?',
      'answer': 'Interest earned on both the principal and previously earned interest',
      'options': [
        'Interest earned on both the principal and previously earned interest',
        'Interest earned only on the principal',
        'A type of bank account',
        'A loan payment method'
      ],
    },
    {
      'question': 'What is diversification?',
      'answer': 'Spreading investments across different assets to reduce risk',
      'options': [
        'Spreading investments across different assets to reduce risk',
        'Investing all money in one stock',
        'Saving money in a bank account',
        'Taking out multiple loans'
      ],
    },
    {
      'question': 'What is a budget?',
      'answer': 'A financial plan for managing income and expenses',
      'options': [
        'A financial plan for managing income and expenses',
        'A type of investment',
        'A bank account',
        'A credit card'
      ],
    },
    {
      'question': 'What is an emergency fund?',
      'answer': 'Money saved for unexpected expenses',
      'options': [
        'Money saved for unexpected expenses',
        'A type of loan',
        'A retirement account',
        'A credit limit'
      ],
    },
  ];

  late List<Map<String, dynamic>> _quizQuestions;
  final PageController _pageController = PageController();
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _quizQuestions = List.from(_allQuestions)..shuffle();
    if (_quizQuestions.length > 5) {
      _quizQuestions = _quizQuestions.sublist(0, 5);
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _pageController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _quizQuestions.length,
        itemBuilder: (context, index) {
          return _buildQuestionCard(_quizQuestions[index], index);
        },
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Question ${index + 1}/${_quizQuestions.length}',
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () => _speak(question['question']),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...question['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AnimatedButton(
                  text: option,
                  onPressed: () {
                    if (option == question['answer']) {
                      widget.onSuccess();
                      if (index < _quizQuestions.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    } else {
                      widget.onFailure();
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const AnimatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}








class ConnectedLearningPath extends StatelessWidget {
  final List<Map<String, dynamic>> modules;
  final Function(Map<String, dynamic>) onModuleTap;

  const ConnectedLearningPath({
    Key? key,
    required this.modules,
    required this.onModuleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: PathPainter(modules),
            ),
            ...List.generate(modules.length, (index) {
              // Calculate position for each module circle
              final x = _getXPosition(index, constraints.maxWidth);
              final y = _getYPosition(index, constraints.maxHeight);

              return Positioned(
                left: x - 40, // Adjust for circle size
                top: y - 40,
                child: GestureDetector(
                  onTap: () => onModuleTap(modules[index]),
                  child: ModuleCircle(
                    module: modules[index],
                    index: index,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  double _getXPosition(int index, double maxWidth) {
    // Zigzag pattern horizontally
    final segment = maxWidth / 4;
    if (index % 2 == 0) {
      return segment;
    } else {
      return segment * 3;
    }
  }

  double _getYPosition(int index, double maxHeight) {
    // Distribute vertically
    final segment = maxHeight / (modules.length + 1);
    return segment * (index + 1);
  }
}

class ModuleCircle extends StatelessWidget {
  final Map<String, dynamic> module;
  final int index;

  const ModuleCircle({
    Key? key,
    required this.module,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: module['completed'] ? Colors.teal : Colors.white,
        border: Border.all(color: Colors.teal, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            module['completed'] ? Icons.check_circle : Icons.play_circle_fill,
            color: module['completed'] ? Colors.white : Colors.teal,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            'Lesson ${index + 1}',
            style: TextStyle(
              color: module['completed'] ? Colors.white : Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final List<Map<String, dynamic>> modules;

  PathPainter(this.modules);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.teal.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();
    final segment = size.height / (modules.length + 1);

    for (var i = 0; i < modules.length - 1; i++) {
      final startX = i % 2 == 0 ? size.width / 4 : (size.width / 4) * 3;
      final startY = segment * (i + 1);
      final endX = (i + 1) % 2 == 0 ? size.width / 4 : (size.width / 4) * 3;
      final endY = segment * (i + 2);

      if (i == 0) {
        path.moveTo(startX, startY);
      }

      // Create curved path between points
      final controlPoint1 = Offset(startX, startY + segment / 2);
      final controlPoint2 = Offset(endX, endY - segment / 2);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endX,
        endY,
      );
    }

    // Draw dotted path for incomplete sections
    final dashPath = Path();
    var distance = 0.0;
    var dash = true;
    final pathMetrics = path.computeMetrics();
    
    for (final metric in pathMetrics) {
      while (distance < metric.length) {
        final dashLength = dash ? 15.0 : 8.0;
        if (dash) {
          final extractPath = metric.extractPath(distance, distance + dashLength);
          dashPath.addPath(extractPath, Offset.zero);
        }
        distance += dashLength;
        dash = !dash;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => false;
}
