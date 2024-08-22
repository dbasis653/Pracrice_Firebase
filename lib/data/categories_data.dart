import 'package:buy_list/model/category_model.dart';
import 'package:flutter/material.dart';

final categories = {
  Categories.vegetables: CategoryModel(
    categoryName: 'Vegetables',
    categoryColor: const Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: CategoryModel(
    categoryName: 'Fruit',
    categoryColor: const Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: CategoryModel(
    categoryName: 'Meat',
    categoryColor: const Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: CategoryModel(
    categoryName: 'Dairy',
    categoryColor: const Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: CategoryModel(
    categoryName: 'Carbs',
    categoryColor: const Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: CategoryModel(
    categoryName: 'Sweets',
    categoryColor: const Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: CategoryModel(
    categoryName: 'Spices',
    categoryColor: const Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: CategoryModel(
    categoryName: 'Convenience',
    categoryColor: const Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: CategoryModel(
    categoryName: 'Hygiene',
    categoryColor: const Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.others: CategoryModel(
    categoryName: 'Other',
    categoryColor: const Color.fromARGB(255, 0, 225, 255),
  ),
};
