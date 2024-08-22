import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Firebase Documentation for all methods:
//https://firebase.google.com/docs/reference/rest/database

import 'package:buy_list/model/category_model.dart';
import 'package:buy_list/data/categories_data.dart';
import 'package:buy_list/provider/grocery_list_provider.dart';
import 'package:buy_list/model/grocery_items_model.dart';

class AddNew extends ConsumerStatefulWidget {
  const AddNew({super.key});

  @override
  ConsumerState<AddNew> createState() => _AddNewState();
}

class _AddNewState extends ConsumerState<AddNew> {
  final _formKey = GlobalKey<FormState>();

  var enteredName = '';
  var enteredQuantity = 1;
  var selectedCategory = categories[Categories.carbs]!;
  bool isSent = false;

  void addItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSent = true;
      });
      _formKey.currentState!.save();
      final url = Uri.https(
          'buylist-b840d-default-rtdb.firebaseio.com', 'shopping-list.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': enteredName,
            'quantities': enteredQuantity,
            'category': selectedCategory.categoryName,
          },
        ),
      );

      print(response.body);
      print(response.statusCode);

      if (!context.mounted) {
        return;
      } /* If contenxt is not mount with the current widget( eg, if we reload the context of that widget will be changed),
        then  Navigator.pop(context); will not be executed */

      final Map<String, dynamic> responseData = json.decode(response.body);

      ref.read(groceryProvider.notifier).addNewItem(
            GroceryItems(
              name: enteredName,
              quantities: enteredQuantity,
              category: selectedCategory,
              id: responseData['name'],
            ),
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Name must not be empty and more then one character';
                  }
                  return null;
                },
                onSaved: (value) {
                  enteredName = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: enteredQuantity.toString(),
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.parse(value) < 1) {
                          return 'Add atleaast one quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            // value: selectedCategory,
                            value: category.value,

                            child: Row(
                              children: [
                                Container(
                                    height: 15,
                                    width: 15,
                                    color: category.value.categoryColor),
                                const SizedBox(width: 10),
                                Text(category.value.categoryName),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSent
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: isSent ? null : addItem,
                    child: isSent
                        ? const SizedBox(
                            height: 15,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
