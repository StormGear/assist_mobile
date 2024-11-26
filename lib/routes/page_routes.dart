import 'package:assist/features/home/screens/setup.dart';
import 'package:assist/features/welcome/screens/welcome.dart';
import 'package:assist/features/onboarding/onboarding.dart';
import 'package:assist/features/signin/signin.dart';
import 'package:assist/features/signup/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A list of routes for the application using the GetX package. Each
/// route is represented by a `GetPage` object, representing the app's main routes.
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: '/welcome', page: () => const WelcomeScreen()),
  GetPage(name: '/signup', page: () => const SignUp()),
  GetPage(name: '/signin', page: () => const SignIn()),
  GetPage(name: '/home', page: () => const Setup()),
];

/// `openingRoutes` represents routes to the initial screens of the application.
final Map<String, WidgetBuilder> openingRoutes = <String, WidgetBuilder>{
  '/onboarding': (context) => const Onboarding(),
};
