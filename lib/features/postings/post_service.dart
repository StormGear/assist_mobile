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
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];
  final ScrollController _scrollController = ScrollController();
  final PostController _postController = Get.put(PostController());
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _phoneNumber = '';
  final TextEditingController _phoneController = TextEditingController();

  String? _phoneValidator(PhoneNumber? value) {
    log("Phone controller value: ${_phoneController.text}");
    if (value != null && value.number.length != 10) {
      log("Phone number is ${value.number}");
      return 'Please enter 10 digits';
    } else {
      // remove the first 0 from the phone numb
      _phoneController.text = value!.number.substring(1);
    }
    return null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _formKey.currentState?.dispose();
    _businessNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

  bool isFormValid() {
    // Check if a category has been selected
    if (_postController.category.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please select a category',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    // Check if a region has been selected
    if (_postController.region.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please select a region',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    // Check if at least 3 images have been selected
    if (_selectedImages.length < 3) {
      Fluttertoast.showToast(
          msg: 'Please select at least 3 images',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    // Check if a keyword has been selected
    if (_postController.keywords.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please select at least one keyword',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    if (_phoneNumber.length < 10) {
      Fluttertoast.showToast(
          msg: 'Please enter a valid phone number',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    return true;

    // Check if the phone number is valid
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
          "Post a Service",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/categories');
                  },
                  title: Text('Category'),
                  subtitle: Obx(() => Text(_postController.getCategory.isEmpty
                      ? 'Select a category under which your product falls'
                      : _postController.getCategory)),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withAlpha(30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/regions');
                  },
                  title: Text('Region'),
                  subtitle: Obx(
                    () => Text(_postController.getRegion.isEmpty
                        ? 'Select your region of primary operation'
                        : _postController.getRegion),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withAlpha(30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Gap(20),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: _businessNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a business name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Business Name',
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                'Select keywords that best describe your service'),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed('/keywords');
                        },
                        title: Text('Select Keywords'),
                        subtitle: Obx(() => Text(
                            _postController.getKeywords.isEmpty
                                ? "Keywords help users find your service"
                                : _postController.getKeywords.join(','))),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: primaryColor),
                        tileColor: primaryColor.withAlpha(30),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                    'Kindly provide a detailed description of your product, doing so will help users understand what you offer better'),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: IntlPhoneField(
                  disableLengthCheck: true,
                  onSubmitted: (val) {
                    log("Submitted phone number is $val");
                  },
                  validator: _phoneValidator,
                  controller: _phoneController,
                  onChanged: (phone) {
                    setState(() {
                      _phoneNumber = phone.countryCode + _phoneController.text;
                    });
                    log("Phone number is(onchanged) $_phoneNumber");
                  },
                  pickerDialogStyle: PickerDialogStyle(
                      countryCodeStyle: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      countryNameStyle: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      searchFieldCursorColor: primaryColor,
                      searchFieldInputDecoration: InputDecoration(
                        hintText: 'Search a country',
                        hintStyle: TextStyle(color: primaryColor),
                        suffixIcon: Icon(Icons.search, color: primaryColor),
                      ),
                      backgroundColor: Colors.white),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  initialCountryCode: 'GH',
                ),
              ),
              Gap(30),
              SizedBox(
                width: size.width * 0.5,
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

                    if (_formKey.currentState!.validate()) {
                      try {
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
                          'category': _postController.category.toString(),
                          'region': _postController.region.toString(),
                          'keywords': _postController.keywords.toList(),
                          'description': _descriptionController.text,
                          'business_name': _businessNameController.text,
                          'phone': _phoneNumber,
                          'created_at': DateTime.now(),
                        };
                        String serviceDocumentId =
                            await PostController.instance.addServicePost(post);

                        if (serviceDocumentId.isNotEmpty) {
                          await StorageController.instance
                              .addServicePostImagestoFirebaseStorage(
                                  serviceDocumentId, _selectedImages);
                        }

                        Fluttertoast.showToast(
                            msg: "Service posted successfully!",
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
                        if (mounted) {
                          setState(() {
                            loading = false;
                          });
                        }
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
                      : const Text("Post Service"),
                ),
              ),
              Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}
