import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/category_meals.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meal_detail.dart';
import 'package:meal_app/screens/tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoritedMeals = [];

  void toggleFavorite(String mealId) {
    final existingIndex =
        favoritedMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoritedMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoritedMeals.any((meal) => meal.id == id);
  }

  void setFilters(Map<String, bool> filtersData) {
    setState(() {
      filters = filtersData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }

        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }

        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      home: TabsScreen(favoritedMeals),
      initialRoute: '/',
      routes: {
        CategoryMealsScreen.routeName: (BuildContext ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (BuildContext ctx) =>
            MealDetailScreen(toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (BuildContext ctx) =>
            FilterScreen(filters, setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
