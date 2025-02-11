import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness
        .dark, //Setting the Brightness to Dark  so that this can be used as Dark ThemeData
    scaffoldBackgroundColor:
        Colors.black, //Setting the Text Theme to DarkTextTheme
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 48.0),
      displayMedium: TextStyle(color: Colors.white, fontSize: 40.0),
      displaySmall: TextStyle(color: Colors.white, fontSize: 32.0),
      headlineLarge: TextStyle(color: Colors.white, fontSize: 28.0),
      headlineMedium: TextStyle(color: Colors.white, fontSize: 24.0),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 20.0),
      titleLarge: TextStyle(color: Colors.white, fontSize: 18.0),
      titleMedium: TextStyle(color: Colors.white, fontSize: 16.0),
      titleSmall: TextStyle(color: Colors.white, fontSize: 14.0),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16.0),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14.0),
      bodySmall: TextStyle(color: Colors.white, fontSize: 12.0),
      labelLarge: TextStyle(color: Colors.white, fontSize: 14.0),
      labelMedium: TextStyle(color: Colors.white, fontSize: 12.0),
      labelSmall: TextStyle(color: Colors.white, fontSize: 10.0),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: primaryColor, width: 2.0),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness
        .light, //Setting the Brightness to light  so that this can be used as Light ThemeData
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withAlpha(30),
      selectionHandleColor: primaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      splashFactory: InkRipple.splashFactory,
      overlayColor: WidgetStateProperty.all<Color>(primaryColor.withAlpha(30)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
      shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        splashFactory: InkRipple.splashFactory,
        overlayColor:
            WidgetStateProperty.all<Color>(primaryColor.withAlpha(30)),
        foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontSize: 48.0),
      displayMedium: TextStyle(color: Colors.black, fontSize: 40.0),
      displaySmall: TextStyle(color: Colors.black, fontSize: 32.0),
      headlineLarge: TextStyle(color: Colors.black, fontSize: 28.0),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 24.0),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 20.0),
      titleLarge: TextStyle(color: Colors.black, fontSize: 18.0),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16.0),
      titleSmall: TextStyle(color: Colors.black, fontSize: 14.0),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16.0),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14.0),
      bodySmall: TextStyle(color: Colors.black, fontSize: 12.0),
      labelLarge: TextStyle(color: Colors.black, fontSize: 14.0),
      labelMedium: TextStyle(color: Colors.black, fontSize: 12.0),
      labelSmall: TextStyle(color: Colors.black, fontSize: 10.0),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor:
            WidgetStateProperty.all<Color>(primaryColor.withAlpha(30)),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: primaryColor, width: 2.0),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
