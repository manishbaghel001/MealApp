import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabBarbottom.dart';
import './screens/filters.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'glutene': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriateMeal = [];
  void _saveFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['glutene'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriateMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriateMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriateMeal.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isFavoriate(String id) {
    return _favoriateMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: debugDisableShadows,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      //home: TabBar(),
      routes: {
        '/': (ctx) => TabBarScreen(_favoriateMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailsScreen.routeName: (ctx) =>
            MealDetailsScreen(_toggleFavorite,isFavoriate),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _saveFilter),
      },
    );
  }
}
