import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // Sample data for the list
  final List<String> _allItems = [
    'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
    'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
    'Mango', 'Nectarine', 'Orange', 'Papaya', 'Quince',
    'Raspberry', 'Strawberry', 'Tangerine', 'Watermelon'
  ];
  
  // Items filtered by search
  List<String> _filteredItems = [];
  
  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all items
    _filteredItems = _allItems;
    
    // Add listener to search controller
    _searchController.addListener(_filterItems);
  }

  // Filter items based on search query
  void _filterItems() {
    final String query = _searchController.text.toLowerCase();
    
    setState(() {
      if (query.isEmpty) {
        // If search is empty, show all items
        _filteredItems = _allItems;
      } else {
        // Filter items that contain the query
        _filteredItems = _allItems
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search ListView Example'),
      ),
      body: Column(
        children: [
          // Search TextField
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter search term...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // Clear button
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                ),
              ),
            ),
          ),
          
          // ListView with filtered items
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text('No matching items found'))
                : ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredItems[index]),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected: ${_filteredItems[index]}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}