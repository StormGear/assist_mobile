import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/chatbot/chat_history.dart';
import 'package:assist/features/home/screens/home.dart';
import 'package:assist/features/postings/post.dart';
import 'package:assist/features/settings/screens/settings.dart';
import 'package:assist/messages/chat_screen.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        iconData: Icons.add,
        title: "Post",
        tabColor: Colors.pink,
      ),
      const TabData(
        iconData: Icons.chat,
        title: "Chat",
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

  void _startNewChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final userIdController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Start New Chat'),
          content: TextField(
            controller: userIdController,
            decoration: const InputDecoration(hintText: 'Enter User ID'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      conversationId: userIdController.text,
                    ),
                  ),
                );
              },
              child: const Text('Start Chat'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: switch (_currentPage) {
          0 => AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leadingWidth: 70,
                leading: Row(
                  children: [
                    Gap(10),
                    Image.asset('assets/images/logo/favicon.png'),
                  ],
                ),
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
          1 => AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Post Service/Business",
                style: TextStyle(
                    color: primaryColor,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
            ),
          2 => AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Chat",
                style: TextStyle(
                    color: primaryColor,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              automaticallyImplyLeading: false,
              actions: [
                // IconButton(
                //   iconSize: 30,
                //   icon: Icon(
                //     Icons.chat,
                //     color: primaryColor,
                //   ),
                //   onPressed: () {
                //     _startNewChat(context);
                //   },
                // ),
              ],
            ),
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
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              switch (_currentPage) {
                0 => Home(),
                1 => Post(),
                2 => ChatHistory(),
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
