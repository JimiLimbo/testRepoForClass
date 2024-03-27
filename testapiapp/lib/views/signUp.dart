import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: reEnterPasswordController,
              decoration: InputDecoration(
                labelText: 'Re-Enter Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get user input
                String userName = userNameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                String reEnterPassword = reEnterPasswordController.text;

                // Validate user input
                if (userName.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty ||
                    reEnterPassword.isEmpty) {
                  // Show error message if any field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields are required')));
                  return;
                }

                if (password != reEnterPassword) {
                  // Show error message if passwords don't match
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')));
                  return;
                }

                // Make API call to register user
                final url =
                    'http://10.0.2.2/flutter_db_test/postUsers.php'; // Replace with your API endpoint
                final response = await http.post(
                  Uri.parse(url),
                  body: {
                    'email': email,
                    'userName': userName,
                    'password': password,
                  },
                );

                // Handle API response
                if (response.statusCode == 201) {
                  // Registration successful
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User registered successfully')));
                  // Optionally, navigate to the login page after successful registration
                  Navigator.pop(
                      context); // Go back to the previous page (login page)
                } else {
                  // Registration failed
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Failed to register user. Please try again later.')));
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to login page
                Navigator.pop(
                    context); // Go back to the previous page (login page)
              },
              child: Text(
                'Already have an account? Login here',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
