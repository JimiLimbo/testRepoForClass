import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'views/login.dart';
// Importing custom widgets and models


// The main entry point of the application.
void main() {
  runApp(const MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// Builds the MaterialApp which sets up the theme and home route of the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test API',
      theme: ThemeData(
          // Setting the primary color scheme of the app
          colorScheme: ColorScheme.fromSwatch(primarySwatch: MaterialColor(0xFFD38520, {
            50: Color(0xFFFFF3E0),
            100: Color(0xFFFFE0B2),
            200: Color(0xFFFFCC80),
            300: Color(0xFFFFB74D),
            400: Color(0xFFFFA726),
            500: Color(0xFFD38520), // Your custom primary color
            600: Color(0xFFD38520),
            700: Color(0xFFD38520),
            800: Color(0xFFD38520),
            900: Color(0xFFD38520),
          })),
        ),
      // Setting SplashScreen as the home route
      home: const SplashScreen(),
    );
  }
}

// SplashScreen widget that shows a loading indicator before navigating to MyHomePage
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // Using initState to perform actions when the widget is inserted into the widget tree
  void initState() {
    super.initState();
    // Using a Timer to navigate to MyHomePage after a delay
    Timer(const Duration(seconds: 5), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to LoginPage instead of MyHomePage
        );
      }
    });
  }
// Building the UI of the SplashScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Displaying a background image
          OverflowBox(
            // Making the image slightly larger than the screen to hide the watermark
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height * 1.1, // Adjust the multiplier as needed
            maxHeight: MediaQuery.of(context).size.height * 1.1, // Adjust the multiplier as needed
            child: Image.asset(                                  // I think it looks good
              'assets/images/myCampusMarket.png',  // I can get more images for the rest of the backgrounds too, unless we just want colors.
              fit: BoxFit.cover, // Cover ensures the image covers the screen area without distortion
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Campus Market', // App's name or any other text you want to display
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Choose a color that contrasts with the background
                ),
              ),
              SizedBox(height: 20), // Space between text and the progress indicator
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}



