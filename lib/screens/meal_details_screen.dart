import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  final Function toggleFavorites;
  final Function isFavorites;
  MealDetailsScreen(this.toggleFavorites,this.isFavorites);
  Widget buildText(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .headline1
              .copyWith(fontSize: 25, color: Colors.black)),
    );
  }

  Widget buildList(Widget child) {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeals = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${selectedMeals.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              width: double.infinity,
              child: Image.network(
                selectedMeals.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildText(context, "Ingredients"),
            buildList(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectedMeals.ingredients[index],
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                ),
                itemCount: selectedMeals.ingredients.length,
              ),
            ),
            buildText(context, 'Steps'),
            buildList(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeals.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeals.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorites(mealId)?Icons.star:Icons.star_border,
        ),
        onPressed:()=> toggleFavorites(mealId),
      ),
    );
  }
}
