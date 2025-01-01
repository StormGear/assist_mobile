import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(20),
                        spreadRadius: 5,
                        blurRadius: 3,
                        offset: const Offset(2, 2),
                      ),
                      BoxShadow(
                        color: Colors.grey.withAlpha(20),
                        spreadRadius: 5,
                        blurRadius: 3,
                        offset: const Offset(-2, -2),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(size.height * 0.01),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        -1, -1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
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
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        -1, -1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
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
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(20),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        -1, -1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
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
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Gap(size.height * 0.04),
                            SizedBox(
                              width: size.width * 0.5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/home');
                                  },
                                  child: const Text("Sign Up").tr()),
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
