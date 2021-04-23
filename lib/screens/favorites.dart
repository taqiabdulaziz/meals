import 'package:flutter/cupertino.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoritedMeals;

  FavoritesScreen(this._favoritedMeals);

  @override
  Widget build(BuildContext context) {
    if (_favoritedMeals.isEmpty) {
      return Center(child: Text('No Favorite Meals'));
    }

    return ListView.builder(
      itemBuilder: (BuildContext ctx, int idx) {
        final displayedMeal = _favoritedMeals[idx];
        return MealItem(
          id: displayedMeal.id,
          title: displayedMeal.title,
          imageUrl: displayedMeal.imageUrl,
          duration: displayedMeal.duration,
          complexity: displayedMeal.complexity,
          affordability: displayedMeal.affordability,
        );
      },
      itemCount: _favoritedMeals.length,
    );
  }
}
