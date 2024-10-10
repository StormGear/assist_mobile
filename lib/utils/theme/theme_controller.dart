
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{
  static ThemeController get instance => Get.find();
   final RxBool isLightTheme = false.obs;

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  void saveThemeStatus() async {
    SharedPreferences pref = await prefs;
    pref.setBool('theme', isLightTheme.value);
  }

  void getThemeStatus() async {
    var isLight = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isLightTheme.value = await isLight.value;
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  
}