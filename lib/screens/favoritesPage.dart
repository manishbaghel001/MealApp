import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_items.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;
  FavoritesScreen(this.favoriteMeal);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return  Center(
          child: Text('No favorites added yet-start adding!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItems(
            id: favoriteMeal[index].id,
            title: favoriteMeal[index].title,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: favoriteMeal.length,
      );
    }
  }
}
