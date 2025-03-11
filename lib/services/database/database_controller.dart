import 'dart:async';
// import 'dart:convert';
import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class DatabaseController extends GetxController {
  static DatabaseController get instance => Get.find();

  // initialize database
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// FCM token for the user
  String? fcmToken;

  /// document id for current user
  String? documentId;

  /// create a new user in db
  Future<String> createUserInDb(Map<String, dynamic> user) async {
    var documentId = '';
    try {
      // Check if there is an active connection
      if (await checkServerReachability()) {
        DocumentReference newDocRef = db.collection('users').doc();

        documentId = await db.runTransaction((transaction) async {
          log('transaction started');
          transaction.set(newDocRef, user, SetOptions(merge: true));
          log("New user document added with ID: ${newDocRef.id}");
          newDocRef.get().then((value) {
            Map<String, dynamic> newUser = value.data() as Map<String, dynamic>;
            UserDetails.instance.setEmail = newUser['email'] ?? '';
            UserDetails.instance.setFirstname = newUser['firstname'];
            UserDetails.instance.setLastname = newUser['lastname'];
            UserDetails.instance.setPhone = newUser['phone'];
          });
          return newDocRef.id;
        }).then((value) {
          log("Transaction successfully completed");
          return value;
        }).catchError((error) {
          log("Failed to complete transaction: $error");
          return '';
        });
        UserDetails.instance.setUserId = documentId;
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
      log('Error creating user in db: ${e.toString()}');
      return '';
    }
  }

  /// Login a user using email and password
  Future<bool> loginUser(Map<String, dynamic> user) async {
    try {
      // Specify the collection
      CollectionReference users = db.collection('users');

      // Query Firestore for documents with 'email' field equal to the given value
      QuerySnapshot querySnapshot = await users
          .where('email', isEqualTo: user['email'])
          .where('password', isEqualTo: user['password'])
          .get();
      String? userId;
      String? userEmail;
      String? userPassword;
      String? userPhone;
      String? userFirstname;
      String? userLastname;
      bool? isDelete;
      bool? isSuspend;
      bool? isDisable;

      log('matching emails: ${querySnapshot.toString()}');
      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> content = doc.data() as Map<String, dynamic>;
          userId = doc.id;
          userPassword = content['password'];
          userEmail = content['email'];
          userPhone = content['phone'];
          userFirstname = content['firstname'];
          userLastname = content['lastname'];
          isDelete = content['is_deleted'];
          isSuspend = content['is_suspended'];
          isDisable = content['is_disabled'];
        }
        log('Email(user) exists in at least one document');
        log({
          'email exists': userEmail == user['email'],
          'isDelete': isDelete,
          'isSuspend': isSuspend,
          'isDisable': isDisable,
          'userId': userId,
        }.toString());
        if (userPassword == user['password']) {
          UserDetails.instance.setUserId = userId ?? '';
          UserDetails.instance.setEmail = userEmail ?? '';
          UserDetails.instance.setFirstname = userFirstname ?? '';
          UserDetails.instance.setLastname = userLastname ?? '';
          UserDetails.instance.setPhone = userPhone ?? '';

          return true; // Email exists in at least one document
        } else {
          return false; // Email exists in at least one document
        }
      } else {
        log('Email(user) does not exist in any document');
        return false;
      }
    } catch (e, s) {
      log('Error: ${e.toString()} stacktrace: $s', name: 'loginUser');
      Fluttertoast.showToast(
          msg: "Error while logging in",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  /// update fields in a document in firebase
  Future<bool> updateUserDocumentFields(
      String userId, Map<String, dynamic> fields) async {
    CollectionReference users = db.collection('users');
    try {
      DocumentSnapshot<Object?> docSnapshot = await users.doc(userId).get();

      log('Document ID retrieved: ${docSnapshot.id}');
      if (await checkServerReachability()) {
        await users.doc(docSnapshot.id).update(fields);
        log('Document fields updated successfully');
        return true;
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
        return false;
      }
    } catch (e) {
      // customSnackbar("Error", e.toString());
      log('Error updating user document (updateUserDocumentFields): ${e.toString()}');
      return false;
    }
  }

  /// check whether user exists in the database based on phone number
  Future<Map<String, dynamic>> checkIfPhoneExists(String phoneNumber) async {
    // Specify the collection
    CollectionReference users = db.collection('users');

    // Query Firestore for documents with 'phone' field equal to the given value
    QuerySnapshot querySnapshot =
        await users.where('phone', isEqualTo: phoneNumber).get();
    bool? isDelete;
    bool? isSuspend;
    bool? isDisable;
    String? phone;
    String? userId;

    log('matching phone numbers: ${querySnapshot.toString()}');
    // Check if any documents match the query
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> content = doc.data() as Map<String, dynamic>;
        phone = content['phone'];
        isDelete = content['isDelete'];
        isSuspend = content['isSuspend'];
        isDisable = content['isDisable'];
        userId = doc.id;
      }
      log('Phone number(user) exists in at least one document');
      log({
        'phone exists': phone == phoneNumber,
        'isDelete': isDelete,
        'isSuspend': isSuspend,
        'isDisable': isDisable,
        'userId': userId,
      }.toString());
      return {
        'phone exists': phone == phoneNumber,
        'isDelete': isDelete,
        'isSuspend': isSuspend,
        'isDisable': isDisable,
        'userId': userId,
      }; // Phone number exists in at least one document
    } else {
      log('Phone number(user) does not exist in any document');
      return {
        'phone exists': false,
      }; // Phone number does not exist in any document
    }
  }

  /// check whether user exists in the database based on phone number
  Future<Map<String, dynamic>> checkIfEmailExists(String emailtext) async {
    try {
      // Specify the collection
      CollectionReference users = db.collection('users');

      // Query Firestore for documents with 'phone' field equal to the given value
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: emailtext).get();
      bool? isDelete;
      bool? isSuspend;
      bool? isDisable;
      String? email;
      String? userId;

      log('matching emails: ${querySnapshot.toString()}');
      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> content = doc.data() as Map<String, dynamic>;
          email = content['email'];
          isDelete = content['isDelete'];
          isSuspend = content['isSuspend'];
          isDisable = content['isDisable'];
          userId = doc.id;
        }
        log('Email(user) exists in at least one document');
        log({
          'email exists': email == emailtext,
          'isDelete': isDelete,
          'isSuspend': isSuspend,
          'isDisable': isDisable,
          'userId': userId,
        }.toString());
        return {
          'email exists': email == emailtext,
          'isDelete': isDelete,
          'isSuspend': isSuspend,
          'isDisable': isDisable,
          'userId': userId,
        }; // Phone number exists in at least one document
      } else {
        // log('Email (user) does not exist in any document');
        return {
          'email exists': false,
        }; // Email does not exist in any document
      }
    } catch (e) {
      log('Error: ${e.toString()}', name: 'checkIfEmailExists');
      Fluttertoast.showToast(
          msg: "Error while checking email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);

      /// TODO: Return error field if database can't be checked or there's an error
      return {
        'email exists': false,
      };
    }
  }

  /// retrieve user from firestore
  Future<Map<dynamic, dynamic>> retrieveUserDataWithID(String userId) async {
    if (!await checkServerReachability()) {
      Fluttertoast.showToast(
          msg: "Error: No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      log('Error: No internet connection');
      return {};
    }
    // Specify the collection
    CollectionReference users = db.collection('users');
    Map<String, dynamic>? user;
    try {
      DocumentSnapshot<Object?> docSnapshot = await users.doc(userId).get();

      user = docSnapshot.data() as Map<String, dynamic>;
      log('User data retrieved');
      return user;
    } catch (e) {
      log("User id($userId) does not exist $e", name: 'retrieveUserDataWithID');
      log("No user with this id found $e", name: 'retrieveUserDataWithID');
      Fluttertoast.showToast(
          msg: "No user with this id found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return {};
    }
  }

  /// Create a review for a service
  Future<bool> createReview(Map<String, dynamic> review) async {
    try {
      // Check if there is an active connection
      if (await checkServerReachability()) {
        DocumentReference newDocRef = db.collection('reviews').doc();

        await db.runTransaction((transaction) async {
          log('transaction started');
          transaction.set(newDocRef, review, SetOptions(merge: true));
          log("New review document added with ID: ${newDocRef.id}");
        }).then((value) {
          log("Transaction successfully completed");
          return true;
        }).catchError((error) {
          log("Failed to complete transaction: $error");
          return false;
        });
        return true;
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
        return false;
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
      log('Error creating review in db: ${e.toString()}');
      return false;
    }
  }

  /// Generic stream for listening to changes in a document
  Stream<DocumentSnapshot>? listenToDocumentChanges(String bookingID) {
    try {
      final DocumentReference docRef = db.collection('bookings').doc(bookingID);
      final Stream<DocumentSnapshot> docStream = docRef.snapshots();
      return docStream;
    } catch (e) {
      log('Error with document stream ${e.toString()}');
      Fluttertoast.showToast(
          msg: "Error with document stream",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }
}
