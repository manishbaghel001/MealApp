import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favoritesPage.dart';
import '../widgets/mainDrawer.dart';
import '../models/meal.dart';

class TabBarScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;
  TabBarScreen(this.favoriteMeal);
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'pages': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'pages': FavoritesScreen(widget.favoriteMeal),
        'title': 'Your Favorites',
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
          style: Theme.of(context).textTheme.headline1.copyWith(
              color: Colors.white, fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
