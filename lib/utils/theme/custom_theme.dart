import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
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
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    )),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 48.0,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 40.0,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 32.0,
        fontFamily: 'Poppins',
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontFamily: 'Poppins',
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontFamily: 'Poppins',
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Poppins',
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Poppins',
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontFamily: 'Poppins',
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontFamily: 'Poppins',
      ),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontFamily: 'Poppins',
      ),
      labelMedium: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontFamily: 'Poppins',
      ),
      labelSmall: TextStyle(
        color: Colors.white,
        fontSize: 10.0,
        fontFamily: 'Poppins',
      ),
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
            fontFamily: 'Poppins',
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
    fontFamily: 'Poppins',
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
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 14.0, fontFamily: 'Poppins'),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1.0, color: Colors.red),
            gapPadding: 2.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1.0, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(width: 1.0, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1.0, color: primaryColor),
            gapPadding: 2.0),
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
          fontFamily: 'Poppins',
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
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(color: Colors.black, fontSize: 48.0, fontFamily: 'Poppins'),
      displayMedium:
          TextStyle(color: Colors.black, fontSize: 40.0, fontFamily: 'Poppins'),
      displaySmall:
          TextStyle(color: Colors.black, fontSize: 32.0, fontFamily: 'Poppins'),
      headlineLarge:
          TextStyle(color: Colors.black, fontSize: 28.0, fontFamily: 'Poppins'),
      headlineMedium:
          TextStyle(color: Colors.black, fontSize: 24.0, fontFamily: 'Poppins'),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontFamily: 'Poppins',
      ),
      titleLarge:
          TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: 'Poppins'),
      titleMedium:
          TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Poppins'),
      titleSmall:
          TextStyle(color: Colors.black, fontSize: 14.0, fontFamily: 'Poppins'),
      bodyLarge:
          TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Poppins'),
      bodyMedium:
          TextStyle(color: Colors.black, fontSize: 14.0, fontFamily: 'Poppins'),
      bodySmall:
          TextStyle(color: Colors.black, fontSize: 12.0, fontFamily: 'Poppins'),
      labelLarge:
          TextStyle(color: Colors.black, fontSize: 14.0, fontFamily: 'Poppins'),
      labelMedium:
          TextStyle(color: Colors.black, fontSize: 12.0, fontFamily: 'Poppins'),
      labelSmall:
          TextStyle(color: Colors.black, fontSize: 10.0, fontFamily: 'Poppins'),
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
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
