import 'package:buy_list/data/categories_data.dart';
import 'package:buy_list/model/category_model.dart';
import 'package:buy_list/model/grocery_items_model.dart';

final groceryItems = [
  GroceryItems(
    id: 'a',
    name: 'Milk',
    quantities: 1,
    category: categories[Categories.dairy]!,
  ),
  GroceryItems(
    id: 'b',
    name: 'Bananas',
    quantities: 5,
    category: categories[Categories.fruit]!,
  ),
  GroceryItems(
    id: 'c',
    name: 'Pork Steak',
    quantities: 1,
    category: categories[Categories.meat]!,
  ),
];
