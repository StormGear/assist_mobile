import 'dart:developer';

import 'package:assist/common_widgets/common_button.dart';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
          "Profile",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 70,
                      backgroundColor: primaryColor.withAlpha(120),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'First Name',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'Last Name',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'Email Address',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: IntlPhoneField(
                  pickerDialogStyle: PickerDialogStyle(
                      countryCodeStyle: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      countryNameStyle: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      searchFieldCursorColor: primaryColor,
                      searchFieldInputDecoration: InputDecoration(
                        hintText: 'Search a country',
                        hintStyle: TextStyle(color: primaryColor),
                        suffixIcon: Icon(Icons.search, color: primaryColor),
                        filled: true,
                        fillColor: primaryColor.withAlpha(30),
                      ),
                      backgroundColor: Colors.white),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor.withAlpha(30),
                    enabledBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    border: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                  initialCountryCode: 'GH',
                  onChanged: (phone) {
                    log(phone.completeNumber);
                  },
                ),
              ),
              Gap(50),
              SizedBox(
                  width: size.width * 0.8,
                  child: CommonButton(text: 'Save Changes', onPressed: () {})),
            ],
          ),
        )),
      ),
    );
  }
}
