import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Importing custom widgets and models
import 'views/itemListPage.dart';
import 'model/item.dart'; 

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
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
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
          MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Test API Page')),
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

// The main home page of the app where users can input items
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Text editing controllers to retrieve the text from input fields
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();

// Building the UI of MyHomePage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Item:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: itemNameController, // Using the controller for item name input
              decoration: InputDecoration(
                hintText: 'Enter item name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Enter Price:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: itemPriceController, // Using the controller for item price input
              decoration: InputDecoration(
                hintText: 'Enter price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _makeAPICallAndNavigateToItemList(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle API call for adding an item and navigating to ItemListPage
  void _makeAPICallAndNavigateToItemList(BuildContext context) async {
    // Constructing the item data from user input
    final item = {
      'item_name': itemNameController.text,
      'item_price': itemPriceController.text,
    };

    // Sending a POST request to add the item to the database
    final postResponse = await http.post(
      Uri.parse('http://10.0.2.2/flutter_db_test/get_items.php'),// Tried 'localhost' wouldn't work
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item),
    );

    // Handling the response from the POST request
    if (postResponse.statusCode == 200) {
      // If the item was added successfully, fetch the updated list of items
      final getResponse = await http.get(Uri.parse('http://10.0.2.2/flutter_db_test/get_items.php'));

      // Handling the response from the GET request
      if (getResponse.statusCode == 200) {
        // Parsing the JSON response into a list of Item objects
        List<Item> items = (json.decode(getResponse.body) as List)
            .map((data) => Item.fromJson(data))
            .toList();
        
        // Navigating to ItemListPage with the fetched items
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ItemListPage(items: items)),
        );
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      throw Exception('Failed to add item');
    }
  }
}

