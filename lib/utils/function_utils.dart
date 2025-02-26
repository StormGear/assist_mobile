import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/services/storage/storage_controller.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> compressImage(File file) async {
  String? mimeType = lookupMimeType(file.path);
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jpg|.jpeg'));
  // final splitted = filePath.substring(0, (lastIndex));
  // final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  Directory? directory = await getApplicationDocumentsDirectory();
  String outPath = '${directory.path}/compressed_${file.path.split('/').last}';

  if (mimeType != null && mimeType.startsWith('image/')) {
    try {
      if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
        final compressedImage = await FlutterImageCompress.compressAndGetFile(
            filePath, outPath,
            minWidth: 1000,
            minHeight: 1000,
            quality: 50,
            format: CompressFormat.png);
        File? compressedFile = File(compressedImage!.path);
        return compressedFile;
      } else {
        final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath,
          outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
        );
        File? compressedFile = File(compressedImage!.path);
        return compressedFile;
      }
    } catch (e) {
      log('Error compressing image: ${e.toString()}', name: 'compressImage');
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  return null;
}

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

//  Hash the password
String hashPassword(String password) {
  // Convert the password string to bytes
  final bytes = utf8.encode(password);
  // Generate the SHA-256 hash
  final hash = sha256.convert(bytes);
  // Return the hash as a hex string
  return hash.toString();
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
