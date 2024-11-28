import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(20),
          CircleAvatar(
            maxRadius: 70,
            // foregroundImage: AssetImage('assets/images/settings/profile.jpg'),
            backgroundImage: AssetImage('assets/images/settings/profile.jpg'),
          ),
          Gap(10),
          Text(
            "John Doe",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Gap(10),
          Container(
            width: size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Help Your Friends, Get Rewarded',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Gap(20),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text('Group Name',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Gap(10),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )),
          Gap(20),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text('Group Name',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Gap(10),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )),
          Gap(20),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text('Group Name',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Gap(10),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )),
          Gap(20)
        ],
      ),
    );
  }
}
