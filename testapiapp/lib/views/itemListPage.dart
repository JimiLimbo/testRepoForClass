import 'package:flutter/material.dart';
import 'package:testapiapp/model/item.dart';
import '../main.dart';

class ItemListPage extends StatelessWidget {
  final List<Item> items;

  const ItemListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home')),
          );
          // Return false to cancel the default back button action (popping the current route)
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Item List'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Home')),
                );
              },
            ),
          ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].name),
              subtitle: Text('\$${items[index].price.toStringAsFixed(2)}'),
            );
          }),
    ));
  }
}
