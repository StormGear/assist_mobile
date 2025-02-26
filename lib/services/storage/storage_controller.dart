import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class StorageController extends GetxController {
  /// access the StorageController instance from anywhere within the app
  static StorageController get instance => Get.find();

  /// Access Firebase storage API
  final _storage = FirebaseStorage.instance;

  /// Remove profile photo from Firebase storage
  /// Remove profile photo from Firebase storage
  Future<bool> removeProfilePhotoFromFirebaseStorage(String documentId) async {
    try {
      // Delete the profile photo from Firebase storage
      var ref = await _storage
          .ref()
          .child('user-profile/profile-photo/$documentId/')
          .listAll();
      for (var item in ref.items) {
        // The items under storageRef.
        log(item.toString());
        await _storage.ref(item.fullPath).delete().whenComplete(() {
          log('Profile photo removed from Firebase Storage');
        });
      }
      return true;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }

  Future<bool> addProfilePhototoFirebaseStorage(
      String documentId, File addedImage) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .get();
    try {
      String name = documentSnapshot['firstname'];
      String fileName =
          name.replaceAll(' ', '_').trim() + p.extension(addedImage.path);
      // Initialize a task to upload image to Firebase storage
      UploadTask task = _storage
          .ref('user-profile/profile-photo/$documentId/$fileName')
          .putFile(addedImage);

      return task.then((snapshot) async {
        try {
          String profilePictureURL = await snapshot.ref.getDownloadURL();
          Map<String, dynamic> uploadImage = {
            'profile_url': profilePictureURL,
          };
          // Update the photoUrl
          await FirebaseFirestore.instance
              .collection('users')
              .doc(documentId)
              .update(uploadImage);
          log("profile picture url: $profilePictureURL");
          return true;
        } catch (e) {
          log("Error message: ${e.toString()}");
          return false;
        }
      });
    } catch (error) {
      log(error.toString());
      return false;
    }
  }

  Future<String> loadProfilePicture() async {
    final Map<dynamic, dynamic> user = await DatabaseController.instance
        .retrieveUserDataWithID(UserDetails.instance.getUserId);
    if (user != {}) {
      if (user['profile_url'] != null) {
        return user['profile_url'];
      } else {
        return '';
      }
    }
    return '';
  }

  // Method for cropping the image file passed through a parameter.
  Future<File?> cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Resize Image',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              activeControlsWidgetColor: primaryColor,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
              ],
            ),
          ],
          compressQuality: 100);
      if (croppedImg == null) {
        return null;
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      log('Error cropping images: ${e.toString()}', name: 'cropImage');
    }
    return null;
  }

  Future<Widget> loadDriverProfilePicture(String imageUrl) async {
    final Map<dynamic, dynamic> user = await DatabaseController.instance
        .retrieveUserDataWithID(UserDetails.instance.getUserId);
    if (user != {}) {
      return imageUrl.isNotEmpty
          ? CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                    minRadius: 70,
                    backgroundImage: imageProvider,
                  ),
              placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const CircleAvatar(
                    minRadius: 70,
                    backgroundImage:
                        AssetImage('assets/images/profile/avatar.png'),
                  )),
              errorWidget: (context, url, error) {
                log(error.toString());
                return const CircleAvatar(
                  minRadius: 70,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                );
              })
          : const CircleAvatar(
              minRadius: 70,
              backgroundImage: AssetImage('assets/images/profile/avatar.png'));
    }
    return const CircleAvatar(
      minRadius: 70,
      backgroundImage: AssetImage('assets/images/profile/avatar.png'),
    );
  }
}
