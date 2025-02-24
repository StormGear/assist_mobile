import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String phoneNumber = '';
  bool loading = false;
  DatabaseController databaseController = DatabaseController();

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/logo/favicon.png')),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.03,
                    horizontal: size.width * 0.03),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(size.width * 0.07),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(size.height * 0.01),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const Gap(20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
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
                            const Gap(20),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
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
                            const Gap(20),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
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
                            const Gap(20),
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
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    hintText: 'Search a country',
                                    hintStyle: TextStyle(color: primaryColor),
                                    suffixIcon:
                                        Icon(Icons.search, color: primaryColor),
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  label: const Text('Phone Number'),
                                  floatingLabelStyle:
                                      const TextStyle(color: primaryColor),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1.0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gapPadding: 2.0),
                                  fillColor: Colors.white,
                                  focusColor: primaryColor,
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1.0, color: Colors.red),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gapPadding: 2.0),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1.0, color: primaryColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      gapPadding: 2.0)),
                              initialCountryCode: 'GH',
                              onChanged: (phone) {
                                setState(() {
                                  phoneNumber =
                                      phone.countryCode + phoneController.text;
                                });
                                log("Phone number is(onchanged) $phoneNumber");
                              },
                            ),
                            const Gap(20),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _isPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  } else if (value.length > 20) {
                                    return 'Password must not exceed 20 characters';
                                  } else if (RegExp(
                                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,20}$')
                                      .hasMatch(value)) {
                                    return 'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Gap(20),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                              ),
                              child: TextFormField(
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _isPasswordVisible,
                                validator: (value) {
                                  if (confirmPasswordController.text !=
                                          passwordController.text ||
                                      passwordController.text.isEmpty) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Gap(size.height * 0.04),
                            SizedBox(
                              width: size.width * 0.5,
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
                                        // Hash the password
                                        String hashedPassword = hashPassword(
                                            passwordController.text);
                                        var user = {
                                          'email': emailController.text,
                                          'phone': phoneNumber,
                                          'password': hashedPassword,
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
                  ],
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/signin');
                    },
                    child: const Text('Login Now!'),
                  ),
                ],
              ),
              const Gap(5),
              SizedBox(
                width: size.width * 0.8,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.03),
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  const Text('or'),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.03),
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ]),
              ),
              const Gap(20),
              SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all<double>(2),
                    foregroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Image(
                        image: AssetImage('assets/images/signin/google.png'),
                        height: 20,
                        fit: BoxFit.fill,
                      ),
                      Gap(8),
                      Text('Sign Up with Google'),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              if (Theme.of(context).platform == TargetPlatform.iOS)
                SizedBox(
                  width: size.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all<double>(2),
                        foregroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: const Row(
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage('assets/images/signin/apple.png'),
                            height: 20,
                          ),
                          Gap(8),
                          Text('Sign Up with Apple'),
                        ],
                      )),
                ),
              const Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}
