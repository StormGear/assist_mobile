import 'package:assist/features/account-validation/account_validate.dart';
import 'package:assist/features/business-details/business_details.dart';
import 'package:assist/features/change-password/change_password.dart';
import 'package:assist/features/home/screens/setup.dart';
import 'package:assist/features/notifications/notifications.dart';
import 'package:assist/features/postings/post_service.dart';
import 'package:assist/features/profile/profile.dart';
import 'package:assist/features/search/search.dart';
import 'package:assist/features/welcome/screens/welcome.dart';
import 'package:assist/features/onboarding/onboarding.dart';
import 'package:assist/features/signin/signin.dart';
import 'package:assist/features/signup/screens/signup.dart';
import 'package:assist/sales/purchase_and_sale.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A list of routes for the application using the GetX package. Each
/// route is represented by a `GetPage` object, representing the app's main routes.
final List<GetPage<dynamic>> appRoutes = [
  GetPage(name: '/welcome', page: () => const WelcomeScreen()),
  GetPage(name: '/signup', page: () => const SignUp()),
  GetPage(name: '/signin', page: () => const SignIn()),
  GetPage(name: '/home', page: () => const Setup()),
  GetPage(name: '/search', page: () => const Search()),
  GetPage(name: '/post-service', page: () => const PostService()),
  GetPage(name: '/profile', page: () => const Profile()),
  GetPage(name: '/post-product', page: () => const PostProduct()),
  GetPage(name: '/account-validation', page: () => const AccountValidation()),
  GetPage(name: '/notifications', page: () => const Notifications()),
  GetPage(name: '/change-password', page: () => const ChangePassword()),
  GetPage(name: '/business-details', page: () => const BusinessDetails()),
];

/// `openingRoutes` represents routes to the initial screens of the application.
final Map<String, WidgetBuilder> openingRoutes = <String, WidgetBuilder>{
  '/onboarding': (context) => const Onboarding(),
};
