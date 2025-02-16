// import 'package:flutter/material.dart';
// // import 'screens/home.dart';
// import 'screens/signup.dart';
// import 'screens/login.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// void main() async {
//   // Ensure that plugin services are initialized
//   WidgetsFlutterBinding.ensureInitialized();

//   // Load environment variables
//   // await dotenv.load(fileName: ".env"); 

//   runApp(MyApp()); 
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.teal, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.purple),
//       ),
//       home: const WelcomeScreen(),
//     );
//   }
// }

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Welcome to Naari Nivesh',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             const SizedBox(
//               width: 300,
//               height: 300,
//               child: Image(
//                 image: AssetImage('assets/images/welcome.jpeg'),
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 minimumSize: const Size(200, 50), // Ensures both buttons have the same size
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                 );
//               },
//               child: const Text(
//                 'Log In',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 minimumSize: const Size(200, 50), // Same size as the Login button
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const SignUpPage()),
//                 );
//               },
//               child: const Text(
//                 'Get Started',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// import 'screens/home.dart';
import 'screens/signup.dart';
import 'screens/login.dart';
import 'screens/scenario.dart'; // Import the ScenarioScreen
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  // await dotenv.load(fileName: ".env"); 

  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal, 
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.purple),
      ),
      home: const WelcomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/scenario') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ScenarioScreen(level: args['level']), // Pass the level
          );
        }
        return null; // Handle other routes or return a default route
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Naari Nivesh',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              height: 300,
              child: Image(
                image: AssetImage('assets/images/welcome.jpeg'),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(200, 50), // Ensures both buttons have the same size
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                'Log In',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(200, 50), // Same size as the Login button
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}