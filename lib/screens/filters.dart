import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool lactoseFree = false;
  bool vegan = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten'];
    lactoseFree = widget.currentFilters['lactose'];
    vegetarian = widget.currentFilters['vegetarian'];
    vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, Function updateHandler) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              };

              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchListTile(
                  'Gluten-free', 'Only include gluten-free meals.', glutenFree,
                  (newValue) {
                setState(() {
                  glutenFree = newValue;
                });
              }),
              buildSwitchListTile('Lactose-free',
                  'Only include lactose-free meals.', lactoseFree, (newValue) {
                setState(() {
                  lactoseFree = newValue;
                });
              }),
              buildSwitchListTile(
                  'Vegetarian', 'Only include vegetarian meals.', vegetarian,
                  (newValue) {
                setState(() {
                  vegetarian = newValue;
                });
              }),
              buildSwitchListTile('Vegan', 'Only include vegan meals.', vegan,
                  (newValue) {
                setState(() {
                  vegan = newValue;
                });
              })
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
