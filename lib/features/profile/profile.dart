import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/common_button.dart';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? imageUrl;
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfilePicture();
  }

  void fetchProfilePicture() async {
    try {
      // imageUrl = await StorageController.instance.loadProfilePicture();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      log(' Error fetching profile picture ${e.toString()}');
    }
  }

  String? phoneValidator(PhoneNumber? value) {
    log("Phone controller value: ${phoneController.text}");
    if (value != null && value.number.length != 10) {
      log("Phone number is ${value.number}");
      return 'Please enter 10 digits';
    } else {
      // remove the first 0 from the phone number
      phoneController.text = value!.number.substring(1);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    File? selectedImage;

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
                    selectedImage != null
                        ? CircleAvatar(
                            minRadius: 70,
                            backgroundImage: FileImage(selectedImage),
                          )
                        : imageUrl != null
                            ? imageUrl!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: imageUrl!,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                          minRadius: 70,
                                          backgroundImage: imageProvider,
                                        ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                          color: primaryColor,
                                        ),
                                    errorWidget: (context, url, error) {
                                      log(error.toString());
                                      return const CircleAvatar(
                                        minRadius: 70,
                                        backgroundColor: primaryColor,
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      );
                                    })
                                : const CircleAvatar(
                                    minRadius: 70,
                                    backgroundImage: AssetImage(
                                        'assets/images/profile/avatar.png'),
                                  )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: const CircleAvatar(
                                  minRadius: 70,
                                  backgroundImage: AssetImage(
                                      'assets/images/profile/avatar.png'),
                                )),
                    GestureDetector(
                      onTap: () async {
                        File? imagePicked = await selectPhoto(context);
                        if (imagePicked != null) {
                          setState(() {
                            selectedImage = imagePicked;
                          });
                        } else {
                          log('Image not selected');
                          if (mounted) {
                            setState(() {
                              selectedImage = null;
                            });
                          }
                          fetchProfilePicture();
                        }
                      },
                      child: Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'First Name and Middle Name',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: lastnameController,
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
                  controller: emailController,
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
                  controller: phoneController,
                  validator: phoneValidator,
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
