import 'package:assist/features/onboarding/onboarding.dart';
import 'package:assist/firebase_options.dart';
import 'package:assist/routes/page_routes.dart';
import 'package:assist/utils/dependency_injection.dart';
import 'package:assist/utils/theme/custom_theme.dart';
import 'package:assist/utils/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

String supabaseKey = String.fromEnvironment('SUPABASE_KEY');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  DependencyInjection.setupDependencies();
  runApp(Assist());
}

class Assist extends StatelessWidget {
  final ThemeController themeController = ThemeController.instance;

  Assist({super.key}) {
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
