import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  others,
}

class CategoryModel {
  CategoryModel({required this.categoryName, required this.categoryColor});
  final String categoryName;
  final Color categoryColor;
}
