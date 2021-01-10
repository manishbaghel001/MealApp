import 'package:flutter/material.dart';
import '../widgets/mainDrawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilter;
  final Map<String, bool> currentFilter;
  FiltersScreen(this.currentFilter,this.saveFilter);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  @override
  initState() {
    _glutenFree = widget.currentFilter['glutene'];
    _lactoseFree = widget.currentFilter['lactose'];
    _vegetarian = widget.currentFilter['vegetarian'];
    _vegan = widget.currentFilter['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String discription, bool changeValue, Function updatValue) {
    return SwitchListTile(
      value: changeValue,
      onChanged: updatValue,
      title: Text(title),
      subtitle: Text(discription),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final saveFilter = {
                  'glutene': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilter(saveFilter);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(25),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 30, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                'Gluten-free',
                'Only include Gluten-free meals',
                _glutenFree,
                (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Lactose-free',
                'Only include Lactose-free meals',
                _lactoseFree,
                (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include Vegetarian meals',
                _vegetarian,
                (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include Vegan meals',
                _vegan,
                (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
