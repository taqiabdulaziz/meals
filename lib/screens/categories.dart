import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: DUMMY_CATEGORIES.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (BuildContext ctx, int idx) {
          final dummyCategory = DUMMY_CATEGORIES[idx];
          return CategoryItem(
              dummyCategory.id, dummyCategory.title, dummyCategory.color);
        });
  }
}
