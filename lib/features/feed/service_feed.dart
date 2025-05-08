import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/common_widgets/feed_shimmer.dart';
import 'package:assist/features/feed/post_card.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Feed extends StatefulWidget {
  const Feed({
    super.key,
    this.category,
  });

  final String? category;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  bool _filterByName = false;
  bool _filterByRating = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // call the function to fetch posts here
    // DatabaseController.instance.getServicePosts(widget.category ?? 'Barbering');
    _fetchServicePosts();
    // DatabaseController.instance.getProductPosts(widget.category ?? 'Barbering');
    // DatabaseController.instance
    //     .getReviewsWithID(UserDetails.instance.getUserId);
  }

  Future<void> _fetchServicePosts() async {
    setState(() {
      loading = true;
    });
    // first clear previous posts
    DatabaseController.instance.posts.clear();
    // then fetch new posts
    await DatabaseController.instance
        .getServicePosts(widget.category ?? 'Barbering');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Feed"),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Apply Filters",
                      style: Theme.of(context).textTheme.headlineSmall),
                  IconButton(
                    icon: Icon(Icons.tune),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterBottomSheet(
                            filterByName: _filterByName,
                            filterByRating: _filterByRating,
                            onFilterChange:
                                (bool filterByName, bool filterByRating) {
                              setState(() {
                                _filterByName = filterByName;
                                _filterByRating = filterByRating;
                              });
                            },
                            onReset: () {
                              setState(() {
                                _filterByName = false;
                                _filterByRating = false;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
            child: Row(
              children: [
                _filterByName == true || _filterByRating == true
                    ? Text('Ordered by: ')
                    : Container(),
                _filterByName ? Text('Name (A-Z)') : Container(),
                Gap(10),
                _filterByRating ? Text('Rating') : Container(),
              ],
            ),
          ),
          if (loading) FeedLoading(),
          if (!loading && DatabaseController.instance.posts.isEmpty)
            const Center(
              child: Text("No service posts available."),
            ),
          if (!loading && DatabaseController.instance.posts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: DatabaseController.instance.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: PostCard(
                        postData: DatabaseController.instance.posts[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final bool filterByName;
  final bool filterByRating;
  final Function(bool, bool) onFilterChange;
  final Function() onReset;

  const FilterBottomSheet({
    super.key,
    required this.filterByName,
    required this.filterByRating,
    required this.onFilterChange,
    required this.onReset,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late bool _filterByName;
  late bool _filterByRating;

  @override
  void initState() {
    _filterByName = widget.filterByName;
    _filterByRating = widget.filterByRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Gap(100),
              Center(
                child: Text("Apply Filters",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order by:",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CheckboxListTile(
                  title: Text("Name (A-Z)"),
                  value: _filterByName,
                  activeColor: primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      _filterByName = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Rating"),
                  value: _filterByRating,
                  activeColor: primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      _filterByRating = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _filterByName = false;
                  _filterByRating = false;
                  widget.onReset();
                  Navigator.pop(context);
                },
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.grey,
                      ),
                    ),
                child: Text("Reset"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onFilterChange(_filterByName, _filterByRating);

                  Navigator.pop(context);
                },
                child: Text("Apply"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
