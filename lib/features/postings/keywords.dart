import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/posts/post_controller.dart';
import 'package:flutter/material.dart';

class Keywords extends StatefulWidget {
  const Keywords({super.key});

  @override
  State<Keywords> createState() => _KeywordsState();
}

class _KeywordsState extends State<Keywords> {
  // Sample data for the list
  final List<String> _allKeywords = [
    'Masons',
    'Carpenters',
    'Plumbers',
    'Electricians',
    'Painters',
    'Cleaners',
    'Welders',
    'Mechanics',
    'Tilers',
    'Dressmakers',
    'Hairdressers',
    'Barbers',
  ];

  // Items filtered by search
  List<String> _filteredKeywords = [];

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, show all items
    _filteredKeywords = _allKeywords;

    // Add listener to search controller
    _searchController.addListener(_filterItems);
  }

  // Filter items based on search query
  void _filterItems() {
    final String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        // If search is empty, show all items
        _filteredKeywords = _allKeywords;
      } else {
        // Filter items that contain the query
        _filteredKeywords = _allKeywords
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
          "Keywords",
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
                hintText: 'Search a keyword...',
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
            child: _filteredKeywords.isEmpty
                ? const Center(child: Text('No matching items found'))
                : ListView.builder(
                    itemCount: _filteredKeywords.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredKeywords[index]),
                        onTap: () {
                       
                          PostController.instance
                              .setCategory(_filteredKeywords[index]);
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
