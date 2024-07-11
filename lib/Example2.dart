import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example2 extends StatefulWidget {
  @override
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final List<String> _items = ["mm 1", "nn 2", "Item 3"];
  List<String> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    _filteredItems = _items.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _filterItems,
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_filteredItems[index]),
          );
        },
      ),
    );
  }
}
