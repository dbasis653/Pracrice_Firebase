// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:buy_list/provider/grocery_list_provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:buy_list/screens/grocery_list_screen.dart';
// import 'package:buy_list/data/categories_data.dart';
// import 'package:buy_list/model/grocery_items_model.dart';

// class LoadItemsProviderNotifier extends StateNotifier<List<dynamic>> {
//   LoadItemsProviderNotifier() : super([]);

//   void loadItems(WidgetRef ref) async {
//     final url = Uri.https(
//         'buylist-b840d-default-rtdb.firebaseio.com', 'shopping-list.json');

//     final response = await http.get(url);
//     /* we want this response even at the start of the app to display the stored items is GroceryList screen */
//     print(response);
//     print(response.body);

//     final Map<String, dynamic> listData = json.decode(response.body);

//     final List<GroceryItems> loadedItems = [];

//     if (response.statusCode >= 400) {
//       error =
//           'Server is Temporarily busy...Please try again Later.'; //use setState() here
//     }

//     for (final item in listData.entries) {
//       final category = categories.entries
//           .firstWhere((cat) => item.value['category'] == cat.value.categoryName)
//           .value;
//       loadedItems.add(
//         GroceryItems(
//             name: item.value['name'],
//             quantities: item.value['quantities'],
//             category: category,
//             id: item.key),
//       );
//     }

//     isLoading = false;

//     ref.watch(groceryProvider.notifier).addLoadItems(loadedItems);
//   }
// }

// final loadItemsProvider =
//     StateNotifierProvider<LoadItemsProviderNotifier, List<dynamic>>((ref) {
//   return LoadItemsProviderNotifier();
// });
