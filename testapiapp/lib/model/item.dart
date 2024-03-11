class Item {
  final int id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.parse(json['item_id']), // Explicitly parse the string to an int
      name: json['item_name'],
      price: double.parse(json['item_price'].toString()), // Also ensure price is correctly handled
    );
  }
}

