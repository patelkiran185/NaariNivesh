import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:naarinivesh/sub-screens/low_finance_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Finance'),
        backgroundColor: Colors.teal,
      ),
      body: AnimationLimiter(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              _buildModuleCard(
                context,
                'Financial Concepts',
                'Basic Financial Concepts',
                Colors.green,
                'assets/images/low_finance.png',
                0.3,
                _buildLowFinanceLessons(context),
              ),
              const SizedBox(height: 16),
              _buildModuleCard(
                context,
                'Financial Planning',
                'Intermediate Financial Planning',
                Colors.orange,
                'assets/images/medium_finance.png',
                0.6,
                _buildMediumFinanceLessons(context),
              ),
              const SizedBox(height: 16),
              _buildModuleCard(
                context,
                'Investment Strategies',
                'Advanced Investment Strategies',
                Colors.red,
                'assets/images/high_finance.png',
                0.1,
                _buildHighFinanceLessons(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    String level,
    String description,
    Color color,
    String imagePath,
    double progress,
    List<Widget> lessons,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LessonScreen(level: level, lessons: lessons),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, object, stackTrace) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(progress * 100).toInt()}% Complete',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLowFinanceLessons(BuildContext context) {
    return [
      ElevatedButton(
        child: const Text('Start Basic Financial Concepts Quiz'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LowFinanceScreen()),
          );
        },
      ),
      const SizedBox(height: 16),
      _buildFlashCard(
        'What is a Budget?',
        'A budget is a financial plan that helps you track your income and expenses to manage money wisely. It includes:\n'
            '• Estimating income\n'
            '• Planning expenses\n'
            '• Monitoring spending\n'
            '• Adjusting as needed',
      ),
      _buildFlashCard(
        'What is Saving?',
        'Saving is setting aside a portion of income for future needs or emergencies. Benefits include:\n'
            '• Financial security\n'
            '• Emergency fund\n'
            '• Achieving financial goals\n'
            '• Earning interest',
      ),
      _buildFlashCard(
        'What is an Emergency Fund?',
        'An emergency fund is a savings account used to cover unexpected expenses, such as medical bills or car repairs. Key points:\n'
            '• Provides financial security\n'
            '• Covers unexpected expenses\n'
            '• Should be easily accessible\n'
            '• Typically 3-6 months of expenses',
      ),
      _buildFlashCard(
        'What is Debt?',
        'Debt is money borrowed from another party, typically a bank or financial institution, that must be repaid with interest. Types of debt include:\n'
            '• Credit card debt\n'
            '• Student loans\n'
            '• Mortgages\n'
            '• Personal loans',
      ),
      _buildFlashCard(
        'What is Interest?',
        'Interest is the cost of borrowing money, typically expressed as a percentage of the principal amount. Types of interest:\n'
            '• Simple interest\n'
            '• Compound interest\n'
            '• Fixed interest\n'
            '• Variable interest',
      ),
      _buildFlashCard(
        'What is a Credit Score?',
        'A credit score is a numerical representation of your creditworthiness, based on your credit history and financial behavior. Factors affecting credit score:\n'
            '• Payment history\n'
            '• Credit utilization\n'
            '• Length of credit history\n'
            '• Types of credit\n'
            '• Recent credit inquiries',
      ),
      _buildFlashCard(
        'What is a Loan?',
        'A loan is a sum of money borrowed from a lender that must be repaid with interest over a specified period. Types of loans:\n'
            '• Personal loans\n'
            '• Auto loans\n'
            '• Student loans\n'
            '• Mortgages',
      ),
      _buildFlashCard(
        'What is a Mortgage?',
        'A mortgage is a type of loan used to purchase real estate, where the property itself serves as collateral. Key points:\n'
            '• Long-term loan\n'
            '• Fixed or variable interest rates\n'
            '• Monthly payments\n'
            '• Includes principal and interest',
      ),
      _buildFlashCard(
        'What is a Credit Card?',
        'A credit card is a payment card that allows you to borrow money from a bank to make purchases, which must be repaid with interest. Benefits and risks:\n'
            '• Convenient payment method\n'
            '• Builds credit history\n'
            '• Potential for high-interest debt\n'
            '• Rewards and benefits',
      ),
      _buildFlashCard(
        'What is a Checking Account?',
        'A checking account is a bank account that allows you to deposit and withdraw money, write checks, and use a debit card. Features:\n'
            '• Easy access to funds\n'
            '• Debit card usage\n'
            '• Online banking\n'
            '• Direct deposit',
      ),
      _buildFlashCard(
        'What is a Savings Account?',
        'A savings account is a bank account that earns interest on the money you deposit, encouraging you to save for future needs. Benefits:\n'
            '• Earns interest\n'
            '• Safe place for savings\n'
            '• Limited withdrawals\n'
            '• FDIC insured',
      ),
      _buildFlashCard(
        'What is a Certificate of Deposit (CD)?',
        'A Certificate of Deposit (CD) is a savings account with a fixed interest rate and fixed maturity date, offering higher interest rates than regular savings accounts. Key points:\n'
            '• Fixed interest rate\n'
            '• Fixed term\n'
            '• Higher interest rates\n'
            '• Penalty for early withdrawal',
      ),
      _buildFlashCard(
        'What is a Mutual Fund?',
        'A mutual fund is an investment vehicle that pools money from multiple investors to purchase a diversified portfolio of stocks, bonds, or other securities. Benefits:\n'
            '• Diversification\n'
            '• Professional management\n'
            '• Liquidity\n'
            '• Access to various asset classes',
      ),
      _buildFlashCard(
        'What is a Stock?',
        'A stock represents ownership in a company and entitles the shareholder to a portion of the company\'s profits and assets. Key points:\n'
            '• Ownership in a company\n'
            '• Potential for capital gains\n'
            '• Dividends\n'
            '• Voting rights',
      ),
      _buildFlashCard(
        'What is a Bond?',
        'A bond is a fixed-income investment where an investor loans money to a borrower, typically a corporation or government, in exchange for periodic interest payments and the return of the principal at maturity. Types of bonds:\n'
            '• Corporate bonds\n'
            '• Government bonds\n'
            '• Municipal bonds\n'
            '• Treasury bonds',
      ),
      _buildFlashCard(
        'What is Diversification?',
        'Diversification is an investment strategy that involves spreading investments across different asset classes to reduce risk. Benefits:\n'
            '• Reduces risk\n'
            '• Balances portfolio\n'
            '• Potential for higher returns\n'
            '• Protects against market volatility',
      ),
      _buildFlashCard(
        'What is a Retirement Account?',
        'A retirement account is a financial account, such as an IRA or 401(k), designed to help you save for retirement with tax advantages. Types of retirement accounts:\n'
            '• Traditional IRA\n'
            '• Roth IRA\n'
            '• 401(k)\n'
            '• 403(b)',
      ),
      _buildFlashCard(
        'What is Financial Planning?',
        'Financial planning is the process of setting financial goals, creating a plan to achieve them, and monitoring progress to ensure financial security. Steps in financial planning:\n'
            '• Assessing financial situation\n'
            '• Setting financial goals\n'
            '• Creating a plan\n'
            '• Monitoring and adjusting',
      ),
      _buildFlashCard(
        'What is a Financial Advisor?',
        'A financial advisor is a professional who provides financial guidance and advice to help individuals manage their finances and achieve their financial goals. Services offered:\n'
            '• Investment advice\n'
            '• Retirement planning\n'
            '• Tax planning\n'
            '• Estate planning',
      ),
    ];
  }

  List<Widget> _buildMediumFinanceLessons(BuildContext context) {
    return [
      ElevatedButton(
        child: const Text('Start Intermediate Financial Planning Quiz'),
        onPressed: () {},
      ),
      const SizedBox(height: 16),
      _buildFlashCard(
        'What is Investing?',
        'Investing is the process of putting money into assets like stocks or bonds to grow wealth over time.',
      ),
      _buildFlashCard(
        'What is a Credit Score?',
        'A credit score is a numerical rating that represents a person\'s creditworthiness based on financial history.',
      ),
    ];
  }

  List<Widget> _buildHighFinanceLessons(BuildContext context) {
    return [
      ElevatedButton(
        child: const Text('Start Advanced Investment Strategies Quiz'),
        onPressed: () {},
      ),
      const SizedBox(height: 16),
      _buildFlashCard(
        'What is a Mutual Fund?',
        'A mutual fund pools money from investors to invest in diversified assets managed by professionals.',
      ),
      _buildFlashCard(
        'What is an ETF?',
        'An Exchange-Traded Fund (ETF) is an investment fund that trades on stock exchanges like individual stocks.',
      ),
    ];
  }

  Widget _buildFlashCard(String question, String answer) {
    final FlutterTts flutterTts = FlutterTts();

    Future<void> _speak(String text) async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 250, 
            width: 250, 
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () => _speak(question),
                ),
              ],
            ),
          ),
        ),
        back: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.teal,
          child: Container(
            height: 250, 
            width: 250, 
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  answer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () => _speak(answer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LessonScreen extends StatelessWidget {
  final String level;
  final List<Widget> lessons;

  const LessonScreen({Key? key, required this.level, required this.lessons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal, // Set the background color to teal
      child: DraggableHome(
        backgroundColor: Colors.teal,
        title: Container(
          color: Colors.teal, // Set the background color to teal
          // child: Text(
          //   '$level Level Lessons',
          //   style: const TextStyle(
          //       color: Colors.white), // Ensure text color is white
          // ),
        ),
        headerExpandedHeight: 0.25,
        headerWidget: Container(
          color: Colors.teal,
          child: Center(
            child: Text(
              level,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: lessons,
      ),
    );
  }
}