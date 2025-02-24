import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
  File? selectedImage;
  String phoneNumber = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseController databaseController = DatabaseController();

  @override
  void initState() {
    super.initState();
    fetchProfilePicture();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    selectedImage != null
                        ? CircleAvatar(
                            minRadius: 70,
                            backgroundImage: FileImage(selectedImage!),
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          width: 30,
                          height: 30,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
              Gap(30),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextFormField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    hintText: 'First Name and Middle Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter at least your first name';
                    }
                    return null;
                  },
                ),
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextFormField(
                  controller: lastnameController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ),
              Gap(20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (!RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Gap(20),
              IntlPhoneField(
                disableLengthCheck: true,
                onSubmitted: (val) {
                  log("Submitted phone number is $val");
                },
                validator: phoneValidator,
                controller: phoneController,
                showDropdownIcon: false,
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
                      isDense: true, // Reduces the height
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      hintText: 'Search a country',
                      hintStyle: TextStyle(color: primaryColor),
                      suffixIcon: Icon(Icons.search, color: primaryColor),
                    ),
                    backgroundColor: Colors.white),
                cursorColor: primaryColor,
                // controller: phoneController,
                decoration: InputDecoration(
                    isDense: true, // Reduces the height
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontFamily: 'Poppins'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    label: const Text('Phone Number'),
                    floatingLabelStyle: const TextStyle(color: primaryColor),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gapPadding: 2.0),
                    fillColor: Colors.white,
                    focusColor: primaryColor,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gapPadding: 2.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1.0, color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gapPadding: 2.0)),
                initialCountryCode: 'GH',
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone.countryCode + phoneController.text;
                  });
                  log("Phone number is(onchanged) $phoneNumber");
                },
              ),
              Gap(50),
              SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                                  style: loading
                                      ? Theme.of(context)
                                          .elevatedButtonTheme
                                          .style
                                          ?.copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    loadingColor),
                                          )
                                      : null,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (phoneNumber.length < 10) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please enter a valid phone number',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: primaryColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        return;
                                      }
                                      try {
                                        if (mounted) {
                                          setState(() {
                                            loading = true;
                                          });
                                        }
                                   
                                        var user = {
                                          'email': emailController.text,
                                          'phone': phoneNumber,
                                          'firstname': firstnameController.text,
                                          'lastname': lastnameController.text,
                                        };
                                        databaseController
                                            .createUserInDb(user)
                                            .then((value) {
                                          if (mounted) {
                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                          Get.toNamed('/home');
                                        });
                                      } catch (e) {
                                        log("Error: $e");
                                        Fluttertoast.showToast(
                                            msg: e.toString(),
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: primaryColor,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  child: loading
                                      ? SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                      : const Text("Sign Up")),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
