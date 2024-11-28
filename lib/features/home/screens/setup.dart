import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/home/screens/home.dart';
import 'package:assist/features/settings/screens/settings.dart';
// import 'package:assist/features/home/screens/home.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  List<TabData> tabs = [];
  final Color _inactiveColor = primaryColor;
  Color currentColor = primaryColor;
  int _currentPage = 0;
  late String currentTitle;

  @override
  void initState() {
    super.initState();
    tabs = [
      const TabData(
        iconData: Icons.home,
        title: "Home",
        tabColor: Colors.deepPurple,
      ),
      const TabData(
        iconData: Icons.search,
        title: "Search",
        tabColor: Colors.pink,
      ),
      const TabData(
        iconData: Icons.alarm,
        title: "Alarm",
        tabColor: Colors.amber,
      ),
      const TabData(
        iconData: Icons.settings,
        title: "Settings",
        tabColor: Colors.teal,
      ),
    ];
    currentTitle = tabs[0].title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: switch (_currentPage) {
          0 => AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    iconSize: 30,
                    icon: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      Get.toNamed('/search');
                    },
                  ),
                ]),
          3 => AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                currentTitle,
                style: TextStyle(
                    color: primaryColor,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
            ),
          _ => AppBar(
              title: Text(currentTitle),
              automaticallyImplyLeading: false,
            ),
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              switch (_currentPage) {
                0 => Home(),
                1 => Text(
                    'Search Page',
                    style: TextStyle(color: currentColor),
                  ),
                2 => Text(
                    'Alarm Page',
                    style: TextStyle(color: currentColor),
                  ),
                3 => Settings(),
                _ => Text(
                    'Home Page',
                    style: TextStyle(color: currentColor),
                  )
              },
            ],
          ),
        ),
        bottomNavigationBar: CubertoBottomBar(
          key: const Key("BottomBar"),
          inactiveIconColor: _inactiveColor,
          tabStyle: CubertoTabStyle.styleNormal,
          selectedTab: _currentPage,
          tabs: tabs
              .map(
                (value) => TabData(
                  key: Key(value.title),
                  iconData: value.iconData,
                  title: value.title,
                  tabColor: value.tabColor,
                  tabGradient: value.tabGradient,
                ),
              )
              .toList(),
          onTabChangedListener: (position, title, color) {
            setState(() {
              _currentPage = position;
              currentTitle = title;
              if (color != null) {
                currentColor = color;
              }
            });
          },
        ));
  }
}
