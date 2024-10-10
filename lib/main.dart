import 'package:assist/features/onboarding/onboarding.dart';
import 'package:assist/routes/page_routes.dart';
import 'package:assist/utils/dependency_injection.dart';
import 'package:assist/utils/theme/custom_theme.dart';
import 'package:assist/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = ThemeController.instance;

  MyApp({super.key}) {
    themeController.getThemeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: appRoutes,
      routes: openingRoutes,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
    );
  }
}
