import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:buy_list/provider/grocery_list_provider.dart';

import 'package:buy_list/screens/add_new_screen.dart';
import 'package:buy_list/model/grocery_items_model.dart';
import 'package:buy_list/data/categories_data.dart';

class GroceryListScreen extends ConsumerStatefulWidget {
  const GroceryListScreen({super.key});

  @override
  ConsumerState<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends ConsumerState<GroceryListScreen> {
  bool isLoading = true;
  String? error;
  String _error = '';

  @override
  void initState() {
    loadItems(ref);
    super.initState();
  }

  void loadItems(WidgetRef ref) async {
    final url = Uri.https(
        'buylist-b840d-default-rtdb.firebaseio.com', 'shopping-list.json');

    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);

      final List<GroceryItems> loadedItems = [];

      if (response.statusCode >= 400) {
        setState(() {
          error = 'Server is Temporarily busy...Please try again Later.';
        });
      }

      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (cat) => item.value['category'] == cat.value.categoryName)
            .value;
        loadedItems.add(
          GroceryItems(
              name: item.value['name'],
              quantities: item.value['quantities'],
              category: category,
              id: item.key),
        );
      }

      isLoading = false;

      ref.watch(groceryProvider.notifier).addLoadItems(loadedItems);
    } catch (err) {
      setState(() {
        _error = 'Something went Wrong';
        isLoading = false;
      });
    }

    /* we want this response even at the start of the app to display the stored items is GroceryList screen */
  }

  void addItem(BuildContext context, WidgetRef ref) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddNew(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceryList = ref.watch(groceryProvider);

    Widget content = Center(
      child: Text(
        'No Item Added',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );

    if (_error.isNotEmpty) {
      content = const Center(
        child: Text('No Internet Connectiion'),
      );
    }
    if (isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (groceryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
          ),
          key: ValueKey(groceryList[index].id),
          onDismissed: (direction) {
            ref.read(groceryProvider.notifier).removeItem(groceryList[index]);
          },
          child: ListTile(
            leading: Container(
              color: groceryList[index].category.categoryColor,
              height: 15,
              width: 15,
            ),
            title: Text(groceryList[index].name),
            trailing: Text(groceryList[index].quantities.toString()),
          ),
        ),
      );
    }

    if (error != null) {
      content = Center(child: Text(error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(groceryProvider.notifier).addItem(context);
              addItem(context, ref);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
