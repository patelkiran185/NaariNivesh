import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Ensure full screen height
          child: Center( // Center content vertically
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevents excessive spacing
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  _buildTextField(Icons.email, 'Email', TextInputType.emailAddress),
                  const SizedBox(height: 20),

                  // Password Field
                  _buildTextField(Icons.lock, 'Password', TextInputType.text, obscureText: true),
                  const SizedBox(height: 15),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password logic
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.purple, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button (Navigates to HomeScreen)
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Sign-up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
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
  Widget _buildTextField(IconData icon, String hintText, TextInputType keyboardType, {bool obscureText = false}) {
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
