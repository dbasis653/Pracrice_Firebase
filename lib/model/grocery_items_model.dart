import 'package:buy_list/model/category_model.dart';

class GroceryItems {
  GroceryItems(
      {this.id,
      required this.name,
      required this.quantities,
      required this.category});
  final String? id;
  final String name;
  final int quantities;
  final CategoryModel category;
}
