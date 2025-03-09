import 'package:assist/features/onboarding/onboarding.dart';
import 'package:assist/firebase_options.dart';
import 'package:assist/routes/page_routes.dart';
import 'package:assist/utils/dependency_injection.dart';
import 'package:assist/utils/theme/custom_theme.dart';
import 'package:assist/utils/theme/theme_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String supabaseKey = String.fromEnvironment('SUPABASE_KEY');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  DependencyInjection.setupDependencies();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      path: 'assets/translations', // Path to your translation files
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp()));
}

// It's handy to then extract the Supabase client in a variable for later uses
final supabase = Supabase.instance.client;

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
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const Onboarding(),
    );
  }
}
