import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isVisible = false;
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
    // Set _isVisible to true after a short delay to trigger the animation
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  _onChanged() {
    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    try {
      // String baseURL =
      //     'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      // String request =
      //     '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';
      // var response = await http.get(Uri.parse(request));
      if (true) {
        // if (response.statusCode == 200) {
        if (mounted) {
          // setState(() {
          //   searchList = json.decode(response.body)['predictions'];
          // });
        }
      }
      //  else {
      //   throw Exception('Failed to load predictions');
      // }
    } catch (e) {
      log('Error ${e.toString()}', name: 'Get Suggestions');
      // customSnackbar('Error getting places predictions', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              // Your other widgets here
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: _isVisible
                    ? 0
                    : -100, // Adjust the value to control the animation
                left: 0,
                right: 0,
                child: Container(
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.3,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 2), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isVisible = false;
                              });

                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                Get.back();
                              });
                            },
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Expanded(
                            child: Text(
                              'Search from several categories',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
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
                                      hintText:
                                          'What would you like help with?',
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          isSearching
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isSearching = false;
                                                      searchController.clear();
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close))
                                              : Container(),
                                        ],
                                      )),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: _isVisible
                    ? 0
                    : -size.height *
                        0.6, // Adjust the value to control the animation
                left: 0,
                right: 0,
                child: Container(
                  height: size.height * 0.73,
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
                              ListTile(
                                onTap: () async {
                                  try {
                                    if (mounted) {
                                      setState(() {
                                        _isVisible = false;
                                      });
                                    }
                                    // DatabaseController
                                    //     .instance.setPickLocationOnMap = true;
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    log('Error ${e.toString()}',
                                        name: 'location from address');
                                  }
                                },
                                title: Text(searchList[index]["description"]),
                              ),
                              Divider(
                                endIndent: size.width * 0.05,
                                indent: size.width * 0.05,
                              )
                            ],
                          );
                        },
                      ),
                      if (searchList.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
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
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
