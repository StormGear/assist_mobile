import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();

   // initialize database
  FirebaseFirestore db = FirebaseFirestore.instance;

  final region = "".obs;
  final category = "".obs;
  final keywords = <String>[].obs;

  // create setters for region and category
  void setRegion(String region) => this.region.value = region;
  void setCategory(String category) => this.category.value = category;

  // create getters for region and category
  String get getRegion => region.value;
  String get getCategory => category.value;

  void addKeyword(String keyword) => keywords.add(keyword);
  void removeKeyword(String keyword) => keywords.remove(keyword);

  // Clear all lists
  void clearAll() {
    setRegion("");
    setCategory("");
    keywords.clear();
  }

   /// create a new user in db
  Future<String> addServicePost(Map<String, dynamic> post) async {
    var documentId = '';
    try {
      // Check if there is an active connection
      if (await checkServerReachability()) {
        DocumentReference newDocRef = db.collection('service_posts').doc();

        documentId = await db.runTransaction((transaction) async {
          log('transaction started');
          transaction.set(newDocRef, post, SetOptions(merge: true));
          log("New service post document added with ID: ${newDocRef.id}");
          newDocRef.get().then((value) {
            
          });
          return newDocRef.id;
        }).then((value) {
          log("Transaction successfully completed");
          return value;
        }).catchError((error) {
          log("Failed to complete transaction: $error");
          return '';
        });
        return documentId;
      } else {
        Fluttertoast.showToast(
            msg: "Error: No internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        log('Error: No internet connection');
        return '';
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      log('Error creating service post in db: ${e.toString()}');
      return '';
    }
  }
}
