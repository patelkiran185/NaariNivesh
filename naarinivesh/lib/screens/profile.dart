import 'package:flutter/material.dart';
import 'package:naarinivesh/utils/BottomNavigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatelessWidget {
  // Sample profile data
  final Map<String, dynamic> profile = {
    'name': 'Lakshmi Devi',
    'location': 'Rajasthan, India',
    'phone': '+91 98765 43210',
    'email': 'lakshmi.devi@gmail.com',
    'memberSince': 'June 2023',
    'skills': ['Hand Embroidery', 'Pickle Making', 'Block Printing'],
    'totalEarnings': '₹25,000',
    'completedOrders': 69,
    'rating': 4.8,
    'financialProgress': {
      'savingsGoal': {'current': 15000, 'target': 25000, 'progress': 0.6},
      'investmentPortfolio': {
        'value': '₹8,500',
        'growth': '+12%',
        'lastUpdated': '2 days ago'
      },
      'financialLiteracy': {
        'coursesCompleted': 3,
        'totalCourses': 5,
        'progress': 0.6
      },
      'creditScore': {
        'score': 720,
        'status': 'Good',
        'improvement': '+50 points'
      }
    },
    'achievements': [
      {'name': 'Top Seller', 'progress': 0.8},
      {'name': 'Quality Champion', 'progress': 0.9},
      {'name': 'Customer Favorite', 'progress': 0.75},
    ],
    'recentTransactions': [
      {
        'type': 'Received Payment',
        'amount': '₹1,500',
        'date': '2 days ago',
        'status': 'completed'
      },
      {
        'type': 'Withdrawn',
        'amount': '₹3,000',
        'date': '1 week ago',
        'status': 'completed'
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Profile Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1DE9B6),
                      Color(0xFF0097A7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      right: -50,
                      top: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    // Profile Info
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.teal.shade300,
                                  Colors.teal.shade500
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                profile['name'][0],
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            profile['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            profile['location'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text(
                                "${profile['rating']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.teal.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Earnings', profile['totalEarnings'],
                            Icons.payment),
                        _buildStatItem(
                            'Orders',
                            '${profile['completedOrders']}',
                            Icons.shopping_bag),
                        _buildStatItem('Skills', '${profile['skills'].length}',
                            Icons.build),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Financial Progress Section
                  Text(
                    "Financial Progress",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildFinancialProgressSection(),

                  SizedBox(height: 24),

                  // Achievements
                  Text(
                    "Achievements",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildAchievementsSection(),

                  SizedBox(height: 24),

                  // Recent Transactions
                  Text(
                    "Recent Transactions",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildTransactionsSection(),

                  SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildGradientButton(
                          "Edit Profile",
                          Icons.edit,
                          [Color.fromARGB(255, 67, 230, 208), Color(0xFF00796B)],
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildGradientButton(
                          "Settings",
                          Icons.settings,
                          [Color.fromARGB(255, 67, 230, 208), Color(0xFF00796B)],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal.shade700, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialProgressSection() {
    return Column(
      children: [
        // Savings Goal Card
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Savings Goal",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹${profile['financialProgress']['savingsGoal']['current']} / ₹${profile['financialProgress']['savingsGoal']['target']}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 8.0,
                  percent: profile['financialProgress']['savingsGoal']
                      ['progress'],
                  backgroundColor: Colors.grey.shade200,
                  progressColor: Colors.teal,
                  barRadius: Radius.circular(4),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Investment Portfolio Card
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Investment Portfolio",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Value",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          profile['financialProgress']['investmentPortfolio']
                              ['value'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        profile['financialProgress']['investmentPortfolio']
                            ['growth'],
                        style: GoogleFonts.poppins(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Financial Literacy Card
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Financial Education",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${profile['financialProgress']['financialLiteracy']['coursesCompleted']}/${profile['financialProgress']['financialLiteracy']['totalCourses']} Courses",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 8.0,
                  percent: profile['financialProgress']['financialLiteracy']
                      ['progress'],
                  backgroundColor: Colors.grey.shade200,
                  progressColor: Colors.teal,
                  barRadius: Radius.circular(4),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Credit Score Card
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Credit Score",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          profile['financialProgress']['creditScore']['score']
                              .toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            profile['financialProgress']['creditScore']
                                ['improvement'],
                            style: GoogleFonts.poppins(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      profile['financialProgress']['creditScore']['status'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: profile['achievements'].map<Widget>((achievement) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  LinearPercentIndicator(
                    lineHeight: 8.0,
                    percent: achievement['progress'],
                    backgroundColor: Colors.grey.shade200,
                    progressColor: Colors.teal,
                    barRadius: Radius.circular(4),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: profile['recentTransactions'].length,
        itemBuilder: (context, index) {
          final transaction = profile['recentTransactions'][index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade50,
              child: Icon(
                transaction['type'] == 'Received Payment'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: Colors.teal,
              ),
            ),
            title: Text(
              transaction['type'],
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              transaction['date'],
              style: GoogleFonts.poppins(fontSize: 12),
            ),
            trailing: Text(
              transaction['amount'],
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: transaction['type'] == 'Received Payment'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientButton(
    String text,
    IconData icon,
    List<Color> colors,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
