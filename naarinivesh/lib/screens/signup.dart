import 'package:flutter/material.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String selectedRole = 'Learner'; // Default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Ensure full screen height
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents excessive spacing
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign up to get started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Name Field
                  _buildTextField(Icons.person, 'Full Name'),
                  const SizedBox(height: 20),

                  // Email Field
                  _buildTextField(Icons.email, 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),

                  // Password Field
                  _buildTextField(Icons.lock, 'Password', obscureText: true),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  _buildTextField(Icons.lock_outline, 'Confirm Password', obscureText: true),
                  const SizedBox(height: 20),

                  // Role Selection Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedRole,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
                        items: ['Mentor', 'Learner'].map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Sign-Up Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Handle sign-up logic
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.teal, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(IconData icon, String hintText, {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
