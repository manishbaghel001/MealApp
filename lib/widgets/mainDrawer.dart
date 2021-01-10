import 'package:flutter/material.dart';
import '../screens/filters.dart';

class MainDrawer extends StatelessWidget {
  Widget buildList(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 35,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5)),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: 150,
          width: double.infinity,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.all(40),
          alignment: Alignment.centerLeft,
          child: Text(
            'Cooking Up!',
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildList('Meals', Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildList('Settings', Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
      ],
    ));
  }
}
