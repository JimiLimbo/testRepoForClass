import 'package:flutter/material.dart';
import 'package:testapiapp/model/item.dart'; // Importing the Item model
import '../main.dart'; // Import for navigating back to the home page

// Defines a stateless widget for displaying a list of items
class ItemListPage extends StatelessWidget {
  final List<Item> items; // A list of Item objects to display

  // Constructor requiring a list of items
  const ItemListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Overrides the default back button action
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home')), // Navigates back to the home page when the back button is pressed
        );
        return false; // Prevents the default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item List'), // Sets the title of the AppBar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Provides an explicit back button in the AppBar
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home')), // Navigates back to the home page when pressed
              );
            },
          ),
        ),
        body: ListView.builder(
          itemCount: items.length, // The number of items to display
          itemBuilder: (context, index) {
            // Builds each item in the list
            return ListTile(
              title: Text(items[index].name), // Displays the item's name
              subtitle: Text('\$${items[index].price.toStringAsFixed(2)}'), // Displays the item's price, formatted to 2 decimal places
            );
          },
        ),
      ),
    );
  }
}
