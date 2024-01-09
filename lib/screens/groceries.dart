import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_6/data/categories.dart';
import 'package:shopping_list_6/screens/new_item.dart';

import 'package:http/http.dart' as http;
import '../models/grocery_item.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  List<GroceryItem> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'udemy-flutter-course-4d9c7-default-rtdb.firebaseio.com',
        'shopping-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData =
        json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries.firstWhere(
          (catItem) => catItem.value.name == item.value['category']).value;
      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }

    setState(() {
      _groceryItems = loadedItems;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    
    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });

  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Groceries'), actions: [
        IconButton(
          onPressed: _addItem,
          icon: const Icon(Icons.add),
        )
      ]),
      body: _groceryItems.isEmpty
          ? const Center(
              child: Text(
                'No items added yet.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: ((context, index) => Dismissible(
                    key: ValueKey(_groceryItems[index].id),
                    onDismissed: (direction) {
                      _removeItem(_groceryItems[index]);
                    },
                    child: ListTile(
                      title: Text(_groceryItems[index].name),
                      trailing: Text(_groceryItems[index].quantity.toString()),
                      leading: Container(
                        height: 30,
                        width: 30,
                        color: _groceryItems[index].category.color,
                      ),
                    ),
                  )),
            ),
    );
  }
}
