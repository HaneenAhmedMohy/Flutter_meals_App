import 'package:flutter/material.dart';
import '../widgets/drawerWidget.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFiltersChanges;
  final Map<String, bool> filtersValue;

  FiltersScreen(this.setFiltersChanges, this.filtersValue);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.filtersValue['glutenFree'];
    _lactoseFree = widget.filtersValue['lactoseFree'];
    _isVegetarian = widget.filtersValue['vegetarian'];
    _isVegan = widget.filtersValue['vegan'];
    super.initState();
  }

  Widget buildSwitchTile(
      String title, bool value, String subtitle, Function changeHandler) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(subtitle),
        onChanged: changeHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: DrawerWidget(),
      body: Column(children: [
        Container(
            child: Text('Adjust your meals.'), padding: EdgeInsets.all(15)),
        Container(
          height: 200,
          child: ListView(children: [
            buildSwitchTile(
              'Gluten-free',
              _glutenFree,
              'Only contains gluten-free meals.',
              (val) {
                setState(() {
                  _glutenFree = val;
                });
              },
            ),
            buildSwitchTile(
              'Lactose-free',
              _lactoseFree,
              'Only contains lactose-free meals.',
              (val) {
                setState(() {
                  _lactoseFree = val;
                });
              },
            ),
            buildSwitchTile(
              'Vegetarian',
              _isVegetarian,
              'Only contains vegetarian meals.',
              (val) {
                setState(() {
                  _isVegetarian = val;
                });
              },
            ),
            buildSwitchTile(
              'Vegan',
              _isVegan,
              'Only contains vegan meals.',
              (val) {
                setState(() {
                  _isVegan = val;
                });
              },
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              final selectedFilters = {
                'glutenFree': _glutenFree,
                'lactoseFree': _lactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian
              };
              widget.setFiltersChanges(selectedFilters);
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
