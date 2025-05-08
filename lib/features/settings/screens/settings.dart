import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map<dynamic, dynamic> userDetails = {};

  @override
  void initState() {
    super.initState();
    // Fetch user details when the widget is initialized
    _fetchUserDetails();
  }

  void _fetchUserDetails() async {
    try {
      userDetails = await DatabaseController.instance
          .retrieveUserDataWithID(UserDetails.instance.getUserId);
      log('User details fetched: $userDetails');
      UserDetails.instance.setProfileUrl = userDetails['profile_url'];
      if (mounted) {
        setState(() {
          userDetails = userDetails;
        });
      }
    } catch (e) {
      log('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(20),
          UserDetails.instance.getProfileUrl.isNotEmpty
              ? Obx(
                  () => CachedNetworkImage(
                      imageUrl: UserDetails.instance.getProfileUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                            minRadius: 70,
                            backgroundImage: imageProvider,
                          ),
                      placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: const CircleAvatar(
                            minRadius: 70,
                            backgroundImage:
                                AssetImage('assets/images/profile/avatar.png'),
                          )),
                      errorWidget: (context, url, error) {
                        log(error.toString());
                        return const CircleAvatar(
                          minRadius: 70,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      }),
                )
              : const CircleAvatar(
                  minRadius: 70,
                  backgroundImage:
                      AssetImage('assets/images/profile/avatar.png'),
                ),
          Gap(10),
          Obx(
            () => Text(
              UserDetails.instance.firstname.string,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Gap(10),
          Obx(
            () => Text(
              UserDetails.instance.email.string,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Gap(20),
          Container(
            width: size.width * 0.8,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/settings/gift.png',
                  width: 20,
                ),
                Gap(10),
                Text(
                  'Help Your Friends, Earn Rewards',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
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
            child:
                Text('Account', style: Theme.of(context).textTheme.titleLarge),
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
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    title: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Edit your profile'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/account-validation');
                    },
                    title: Text(
                      'Account Validation',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Verify your personal information'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/business-details');
                    },
                    title: Text(
                      'Business Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Include more business details'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                    title: Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Reset your password'),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed('/notifications');
                    },
                    title: Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Manage your notifications'),
                  ),
                ],
              )),
          Gap(20),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text('Posts', style: Theme.of(context).textTheme.titleLarge),
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
                      'Manage Posts',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    subtitle: Text('Edit, delete or view your posts'),
                  ),
                  ListTile(
                    onTap: () => Get.toNamed('/certification'),
                    title: Text(
                      'Be Certified',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text('Submit your skill certifications'),
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
