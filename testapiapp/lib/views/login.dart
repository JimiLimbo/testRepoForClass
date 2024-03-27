import 'package:flutter/material.dart';
import 'package:testapiapp/views/signUp.dart';
import 'package:testapiapp/views/aboutUs.dart';
import 'package:testapiapp/views/mainMenu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  // Method to handle login button press
void _login(BuildContext context) async {
  // Extract email and password from text fields
  String email = emailController.text;
  String password = passwordController.text;

  // Make HTTP POST request to your backend API
  var url = Uri.parse('http://10.0.2.2/flutter_db_test/getUsers.php');
  var response = await http.post(
    url,
    body: {
      'email': email,
      'password': password,
    },
  );

  // Check if the request was successful (status code 200)
  if (response.statusCode == 200) {
    // Parse the response JSON
    var data = json.decode(response.body);

    // Check if authentication was successful based on the response from the server
    if (data['authenticated'] == true) {
      // Navigate to MainMenuPage upon successful authentication
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenuPage()),
      );
    } else {
      // Display an error message if authentication fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
  } else {
    // Handle HTTP error (e.g., server error)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred. Please try again later.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: emailController,
                  // Add email text input field
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  // Add password text input field
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(context); // Call _login method on button press
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
              Spacer(),
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

