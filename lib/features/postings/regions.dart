import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/posts/post_controller.dart';
import 'package:flutter/material.dart';

class Regions extends StatefulWidget {
  const Regions({super.key});

  @override
  State<Regions> createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  // Sample data for the list
  final List<String> _allRegions = [
    'Greater Accra',
    'Ashanti',
    'Western',
    'Eastern',
    'Central',
    'Northern',
    'Upper East',
    'Upper West',
    'Volta',
    'Bono',
    'Bono East',
    'Ahafo',
    'Oti',
    'Savannah',
    'North East',
    'Western North'
  ];

  // Items filtered by search
  List<String> _filteredRegions = [];

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all items
    _filteredRegions = _allRegions;

    // Add listener to search controller
    _searchController.addListener(_filterItems);
  }

  // Filter items based on search query
  void _filterItems() {
    final String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        // If search is empty, show all items
        _filteredRegions = _allRegions;
      } else {
        // Filter items that contain the query
        _filteredRegions = _allRegions
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Regions",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
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
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: primaryColor,
                    ),
                hintText: 'Search a region...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // Clear button
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
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
            child: _filteredRegions.isEmpty
                ? const Center(child: Text('No matching items found'))
                : ListView.builder(
                    itemCount: _filteredRegions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredRegions[index]),
                        onTap: () {
                          /// TODO: Setstate of the region chosen
                          ///   /// TODO: Setstate of the category chosen
                          PostController.instance
                              .setRegion(_filteredRegions[index]);
                          Navigator.pop(context);
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
