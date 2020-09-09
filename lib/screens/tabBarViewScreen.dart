import 'package:flutter/material.dart';
import '../models/mealModal.dart';
import '../widgets/drawerWidget.dart';
import '../screens/category_screen.dart';
import '../screens/favoritesScreen.dart';

class TabBarViewScreen extends StatefulWidget {
  final List<MealModal> favoriteMeals;
  TabBarViewScreen(this.favoriteMeals);
  @override
  _TabBarViewScreenState createState() => _TabBarViewScreenState();
}

class _TabBarViewScreenState extends State<TabBarViewScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'}
    ];
    super.initState();
  }

  void _onPressTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ),
      drawer: DrawerWidget(),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onPressTab,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('Categories')),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Favorites'))
          ]),
    );
  }
}
