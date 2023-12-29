import 'package:flutter/material.dart';
import 'package:shopping_list_6/data/dummy_items.dart';
import 'package:shopping_list_6/screens/new_item.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewItem())
    );
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
        itemCount: groceryItems.length,
        itemBuilder: ((context, index) => ListTile(
          title: Text(groceryItems[index].name),
          trailing: Text(groceryItems[index].quantity.toString()),
          leading: Container(
            height: 30,
            width: 30,
            color: groceryItems[index].category.color,
          ),
        )),
      ),
    );
  }
}
