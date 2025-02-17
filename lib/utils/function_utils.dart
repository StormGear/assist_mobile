import 'dart:developer';
import 'dart:io';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/services/storage/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<bool> checkServerReachability() async {
  try {
    log('check server reachability called');
    final response = await http.get(Uri.parse('https://example.com'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } on http.ClientException {
    log('no internet client exception');
    return false;
  } catch (e) {
    return false;
  }
}

Future<File?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  File? tempImage;
  final XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    tempImage = File(image.path);
    tempImage =
        await StorageController.instance.cropImage(imageFile: tempImage);
    return tempImage;
  } else {
    log('User cancelled');
    return null;
  }
}

/// remove profile photo
Future<void> removeProfilePicture() async {
  try {
    // Remove the current profile picture from the database
    await StorageController.instance
        .removeProfilePhotoFromSupabaseStorage(UserDetails.instance.getUserId);
    // Update the user's profile picture in the database
    await DatabaseController.instance
        .updateUserDocumentFields(UserDetails.instance.getUserId, {
      'profile_url': null,
    });
  } catch (error) {
    log('Error removing photo: ${error.toString()}');
  }
}

Future<File?> selectPhoto(BuildContext context) async {
  File? pickedFile;
  await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => BottomSheet(
          backgroundColor: Colors.white,
          onClosing: () {},
          builder: (BuildContext context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: const Icon(
                        Icons.camera,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Camera',
                      ),
                      onTap: () async {
                        pickedFile = await pickImage(ImageSource.camera)
                            .whenComplete(() {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        });
                      }),
                  ListTile(
                      leading: const Icon(
                        Icons.filter,
                        color: primaryColor,
                      ),
                      title: Text(
                        'Pick a file',
                      ),
                      onTap: () async {
                        pickedFile = await pickImage(ImageSource.gallery)
                            .whenComplete(() {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        });
                      }),

                  /// Remove the image
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Remove Picture',
                    ),
                    onTap: () async {
                      await removeProfilePicture();
                      // Set pickedFile to null to indicate that the picture has been removed
                      pickedFile = null;
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )));
  return pickedFile;
}
