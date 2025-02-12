import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/main.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageController extends GetxController {
  /// access the StorageController instance from anywhere within the app
  static StorageController get instance => Get.find();

  /// Remove profile photo from Firebase storage
  Future<void> removeProfilePhotoFromSupabaseStorage(String documentId) async {
    try {
      // Delete the profile photo from Supabase storage
      final List<FileObject> objectsInFolder = await supabase.storage
          .from('avatars')
          .list(path: 'user-profile-pictures/$documentId/');
      for (var object in objectsInFolder) {
        log('Object: $object');
      }
      // final List<FileObject> objects = await supabase
      //       .storage
      //       .from('avatars')
      //       .remove(['user-profile-pictures/$documentId/$fileName']);
    } catch (error) {
      log('Error: ${error.toString()}');
      Fluttertoast.showToast(
          msg: "Error: ${error.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> addProfilePhototoSupabaseStorage(
      String documentId, File addedImage) async {
    try {
      String name = UserDetails.instance.getFirstname.isEmpty
          ? 'user'
          : UserDetails.instance.getFirstname;
      String fileName =
          name.replaceAll(' ', '_').trim() + p.extension(addedImage.path);
      // Initialize a task to upload image to Supabase storage
      final String fullPath = await supabase.storage
          .from('assist-storage') // Replace with your storage bucket name
          .upload('user-profile-pictures/$documentId/$fileName', addedImage);

      if (fullPath.isNotEmpty) {
        log('Profile picture added to Supabase Storage');
        final String publicUrl = supabase.storage
            .from('assist-storage')
            .getPublicUrl('user-profile-pictures/$documentId/$fileName');
        log('Public URL: $publicUrl');
        if (publicUrl.isNotEmpty) {
          Map<String, dynamic> uploadImage = {
            'profile_url': publicUrl,
          };
          log('Would add public  url to the db');
          // Update the photoUrl
          // await FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(documentId)
          //     .update(uploadImage);
          // log("Profile picture url: $publicUrl");
        }
      } else {
        log('Error adding profile picture to Supabase Storage');
      }
    } catch (error) {
      log(error.toString());
      Fluttertoast.showToast(
          msg: "Error: ${error.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
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
