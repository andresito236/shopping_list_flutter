import 'package:flutter/material.dart';
import 'package:shopping_list_6/data/dummy_items.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
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
