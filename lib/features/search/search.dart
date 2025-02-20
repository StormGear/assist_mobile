import 'dart:convert';
import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List searchList = [];
  List items = ['here', 'there', 'everywhere', 'nowhere', 'somewhere'];
  FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
    searchController.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (searchController.text.length > 2) {
      getSuggestion(searchController.text);
    } else {
      setState(() {
        searchList = [];
      });
    }
  }

  void getSuggestion(String input) async {
    String? searchApiKey = dotenv.env['SEARCH_KEY'];

    try {
      String baseURL = 'https://api.tomtom.com/search/2/autocomplete';
      String request = '$baseURL/$input.json?key=$searchApiKey&language=en-US';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            searchList = json.decode(response.body)['results'];
          });
        }
        log('Search List: $searchList');
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      log('Error ${e.toString()}', name: 'Get Suggestions');
      Get.snackbar('Error getting places predictions', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              // Your other widgets here
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(60),
                      spreadRadius: 0.3,
                      blurRadius: 7,
                      offset: const Offset(
                          0, 2), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Gap(20),
                    Row(
                      children: [
                        Gap(20),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Gap(20),
                        Expanded(
                          child: Text(
                            'Search from several categories',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: TextField(
                                controller: searchController,
                                focusNode: searchFocusNode,
                                onTap: () {
                                  // Get.toNamed('/search');
                                },
                                onChanged: (value) {
                                  if (value != '') {
                                    setState(() {
                                      isSearching = true;
                                    });
                                  } else {
                                    setState(() {
                                      isSearching = false;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: 'What would you like help with?',
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isSearching
                                            ? Tooltip(
                                                message: 'Clear search',
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isSearching = false;
                                                        searchController
                                                            .clear();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.close)),
                                              )
                                            : Container(),
                                      ],
                                    )),
                              )),
                        ),
                      ],
                    ),
                    Gap(5)
                  ],
                ),
              ),
              Container(
                height: size.height * 0.5,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Container(
                                width: size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(120),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          primaryColor.withValues(alpha: 63)),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        searchList[index]["segments"][0]
                                            ["value"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                      const Spacer(),

                                      /// TODO: Enable this when this category has been chosen recently, and the user wants to go back to it, implement cache retrieval which
                                      /// means I'll have to cache visited categories
                                      Icon(
                                        Icons.call_made,
                                        color: Colors.black,
                                        weight: 3,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Gap(10),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              /// TODO: Implement expanded here
              Container(
                // height: size.height * 0.15,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Popular Searches',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Gap(15),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          childAspectRatio: 4,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          String item = items[index];
                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                  width: constraints.maxWidth,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.blueAccent),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                      Gap(10),
                                      Text(
                                        item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
