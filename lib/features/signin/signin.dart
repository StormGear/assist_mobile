import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String phoneNumber = '';
  bool loading = false;
  DatabaseController databaseController = DatabaseController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
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
                      'Login',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Gap(size.height * 0.01),
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
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(10),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(10),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        -1, -1), // changes position of shadow
                                  ),
                                ],
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
                            Gap(size.height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                            Gap(size.height * 0.03),
                            SizedBox(
                              width: size.width,
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
                                          'password': hashedPassword,
                                        };
                                        databaseController
                                            .loginUser(user)
                                            .then((value) {
                                          if (mounted) {
                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                          ZIMKit()
                                              .connectUser(
                                            id: UserDetails.instance.getUserId,
                                            name: UserDetails
                                                .instance.getFirstname,
                                          )
                                              .then((_) {
                                            log('User is now connected to Zego');
                                          });

                                          if (value) {
                                            Get.toNamed('/home');
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Invalid email or password. Please try again',
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
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
                                      : const Text("Sign In")),
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
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
                    child: const Text('Register Now!'),
                  ),
                ],
              ),
              const Gap(5),
              // SizedBox(
              //   width: size.width * 0.8,
              //   child: Row(children: [
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.symmetric(
              //             vertical: size.height * 0.01,
              //             horizontal: size.width * 0.03),
              //         height: 1,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     const Text('or'),
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.symmetric(
              //             vertical: size.height * 0.01,
              //             horizontal: size.width * 0.03),
              //         height: 1,
              //         color: Colors.grey,
              //       ),
              //     ),
              //   ]),
              // ),
              // const Gap(20),
              // SizedBox(
              //   width: size.width * 0.8,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ButtonStyle(
              //       elevation: WidgetStateProperty.all<double>(2),
              //       foregroundColor: WidgetStateProperty.all<Color>(
              //           Theme.of(context).primaryColor),
              //       backgroundColor:
              //           WidgetStateProperty.all<Color>(Colors.white),
              //     ),
              //     child: const Row(
              //       textBaseline: TextBaseline.alphabetic,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.baseline,
              //       children: [
              //         Image(
              //           image: AssetImage('assets/images/signin/google.png'),
              //           height: 20,
              //           fit: BoxFit.fill,
              //         ),
              //         Gap(8),
              //         Text('Sign In with Google'),
              //       ],
              //     ),
              //   ),
              // ),
              const Gap(20),
              // SizedBox(
              //   width: size.width * 0.8,
              //   child: ElevatedButton(
              //       onPressed: () {},
              //       style: ButtonStyle(
              //         elevation: WidgetStateProperty.all<double>(2),
              //         foregroundColor: WidgetStateProperty.all<Color>(
              //             Theme.of(context).primaryColor),
              //         backgroundColor:
              //             WidgetStateProperty.all<Color>(Colors.white),
              //       ),
              //       child: const Row(
              //         textBaseline: TextBaseline.alphabetic,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Image(
              //             image: AssetImage('assets/images/signin/apple.png'),
              //             height: 20,
              //           ),
              //           Gap(8),
              //           Text('Sign In with Apple'),
              //         ],
              //       )),
              // ),
              const Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}
