import 'package:assist/common_widgets/constants/colors.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: Text('Home Screen'),
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
