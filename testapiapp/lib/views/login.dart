import 'package:flutter/material.dart';
import 'package:testapiapp/views/signUp.dart';
import 'package:testapiapp/views/aboutUs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

  // Method to navigate to the sign-up page
  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()), // Navigate to sign-up page
    );
  }

  // Method to navigate to the About Us page
  void _navigateToAboutUs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to About Us page
    );
  }

class _LoginPageState extends State<LoginPage> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center( // Wrap with Center widget to center vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Email:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Container( // Wrap TextField with Container for styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  color: Colors.grey[200], // Box background color
                ),
                child: TextField(
                  // Add email text input field
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Container( // Wrap TextField with Container for styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  color: Colors.grey[200], // Box background color
                ),
                child: TextField(
                  // Add password text input field
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement login functionality
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _navigateToSignUp(context);
                },
                child: Text(
                  'Don\'t have an account? Sign Up Here',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spacer(), // Spacer widget to push "About Us" and version to the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _navigateToAboutUs(context);
                    },
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    'Version 0.0.1',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
