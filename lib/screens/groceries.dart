import 'package:flutter/material.dart';
import 'package:shopping_list_6/screens/new_item.dart';

import '../models/grocery_item.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {

  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem())
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ]
      ),
      body: ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: ((context, index) => ListTile(
          title: Text(_groceryItems[index].name),
          trailing: Text(_groceryItems[index].quantity.toString()),
          leading: Container(
            height: 30,
            width: 30,
            color: _groceryItems[index].category.color,
          ),
        )),
      ),
    );
  }
}
