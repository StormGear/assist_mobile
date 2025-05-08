import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends GetxController {
  static UserDetails get instance => Get.find();

  Rx<String> firstname = "".obs;
  Rx<String> lastname = "".obs;
  Rx<String> phone = "".obs;
  Rx<String> email = "".obs;
  Rx<String> userId = "".obs;
  Rx<String> referredBy = "".obs;
  Rx<String> referral = "".obs;
  Rx<String> profileUrl = "".obs;

  String get getFirstname => firstname.value;
  String get getLastname => lastname.value;
  String get getPhone => phone.value;
  String get getEmail => email.value;
  String get getUserId => userId.value;
  String get getReferredBy => referredBy.value;
  String get getReferral => referral.value;
  String get getProfileUrl => profileUrl.value;


  set setFirstname(String value) => firstname.value = value;
  set setLastname(String value) => lastname.value = value;
  set setPhone(String value) => phone.value = value;
  set setEmail(String value) => email.value = value;
  set setUserId(String value) => userId.value = value;
  set setReferredBy(String value) => referredBy.value = value;
  set setReferral(String value) => referral.value = value;
  set setProfileUrl(String value) => profileUrl.value = value;

  // Create a StreamController
  final StreamController<String?> userChangesController =
      StreamController<String?>.broadcast();

  // Get the stream
  Stream<String?> get userChanges => userChangesController.stream;

  void clear() {
    firstname.value = "";
    lastname.value = "";
    phone.value = "";
    email.value = "";
    userId.value = "";
  }

  /// remove user
  Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstname');
    await prefs.remove('lastname');
    await prefs.remove('phone');
    await prefs.remove('email');
    await prefs.remove('userId');
    UserDetails.instance.userChangesController.add(null);
  }

  Future<void> saveUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstname', firstname.value);
    await prefs.setString('lastname', lastname.value);
    await prefs.setString('phone', phone.value);
    await prefs.setString('email', email.value);
    await prefs.setString(
      'userId',
      userId.value,
    );
  }

  Future<void> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    firstname.value = prefs.getString('firstname').toString();
    lastname.value = prefs.getString('lastname').toString();
    phone.value = prefs.getString('phone').toString();
    email.value = prefs.getString('email').toString();
    userId.value = prefs.getString('userId').toString();
    log('UserDetails: loadUser: firstname: ${firstname.value}');
    UserDetails.instance.userChangesController.add(firstname.value);
  }
  
}
