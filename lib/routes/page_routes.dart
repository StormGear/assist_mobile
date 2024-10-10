import 'package:assist/features/home/screens/welcome.dart';
import 'package:assist/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A list of routes for the application using the GetX package. Each
/// route is represented by a `GetPage` object, representing the app's main routes.
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: '/welcome', page: () => const WelcomeScreen()),
];

/// `openingRoutes` represents routes to the initial screens of the application.
final Map<String, WidgetBuilder> openingRoutes = <String, WidgetBuilder>{
  '/onboarding': (context) => const Onboarding(),
};
