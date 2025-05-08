import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/services/posts/post_controller.dart';
import 'package:assist/services/storage/storage_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetCertified extends StatefulWidget {
  const GetCertified({super.key});

  @override
  State<GetCertified> createState() => _GetCertifiedState();
}

class _GetCertifiedState extends State<GetCertified> {
  bool loading = false;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final PostController _postController = Get.put(PostController());

  bool isFormValid() {
    if (_selectedImages.length < 2) {
      Fluttertoast.showToast(
          msg: "Please select at least 2 images.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((image) => File(image.path)));
        });
      }
    } catch (e) {
      // Handle errors here
      log('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Get Certified",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Gap(30),
              Text(
                'Submit your Professional or Vocational Certifications to get verified on Assist as a Certified Artisan.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gap(10),
              Text(
                'Start by uploading clear images of your certificates.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Add a minimum of 3 photos",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Gap(10),
                    GestureDetector(
                        onTap: _pickImages,
                        child: Image.asset(
                            'assets/images/postings/add_photo.png')),
                  ],
                ),
              ),
              // Image previews
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          // Image preview
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          // Delete button
                          Positioned(
                            top: 0,
                            left: 0,
                            child: InkWell(
                              onTap: () => _removeImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              Gap(20),
              SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  style: loading
                      ? Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(loadingColor),
                          )
                      : null,
                  onPressed: () async {
                    if (!isFormValid()) {
                      return;
                    }

                    try {
                      /// TODO: Save Certification to Firestore
                      if (mounted) {
                        setState(() {
                          loading = true;
                        });
                      }
                      List<File> compressedImages = [];
                      for (int i = 0; i < _selectedImages.length; i++) {
                        File? compressedImage =
                            await compressImage(_selectedImages[i]);
                        if (compressedImage != null) {
                          compressedImages.add(compressedImage);
                          _selectedImages.remove(_selectedImages[i]);
                        }
                      }
                      _selectedImages.addAll(compressedImages);

                      var post = {
                        'user_id': UserDetails.instance.userId.string,
                        'created_at': DateTime.now(),
                      };
                      String certificationDocumentId =
                          await _postController.addServicePost(post);

                      if (certificationDocumentId.isNotEmpty) {
                        await StorageController.instance
                            .addServicePostImagestoFirebaseStorage(
                                certificationDocumentId, _selectedImages);
                      }

                      Fluttertoast.showToast(
                          msg: "Certifications submitted successfully!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      if (mounted) {
                        setState(() {
                          loading = false;
                        });
                      }

                      Get.back();
                    } catch (e) {
                      log("Error: $e");
                      Fluttertoast.showToast(
                          msg: e.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: loading
                      ? SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : const Text("Save Changes"),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
