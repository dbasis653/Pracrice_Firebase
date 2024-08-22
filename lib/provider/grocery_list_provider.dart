import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:buy_list/model/grocery_items_model.dart';

class GroceryListProviderNotifier extends StateNotifier<List<GroceryItems>> {
  GroceryListProviderNotifier() : super([]);

  void addNewItem(GroceryItems item) {
    state = [...state, item];
  }

  void removeItem(GroceryItems item) async {
    // final previousState = state;
    final previousState = [...state];

    // final index = state.indexWhere((idx) => idx.id == item.id);
    state = state.where((m) => m.id != item.id).toList();

    final url = Uri.https('buylist-b840d-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    try {
      final response = await http.delete(url);

      // if (response.statusCode != 200) {
      //   state = previousState;
      //   print('Delete request failed with status: ${response.statusCode}');
      // } else {
      //   print('Item deleted successfully: $item');
      // }
    } catch (exeption) {
      // Handle the case where the internet is off or any other exception
      state = previousState;
      print('Exception occurred: $exeption');
    }
  }

  void addLoadItems(List<GroceryItems> loadedList) {
    state = loadedList;
  }
}

var groceryProvider =
    StateNotifierProvider<GroceryListProviderNotifier, List<GroceryItems>>(
        (ref) {
  return GroceryListProviderNotifier();
});
