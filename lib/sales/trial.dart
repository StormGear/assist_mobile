import 'dart:developer';
import 'dart:io';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images);
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
          "Post a Product",
          style: TextStyle(
              color: primaryColor,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/categories');
                  },
                  title: Text('Category'),
                  subtitle:
                      Text("Select a category under which your product falls"),
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
                  subtitle: Text("Select your region of primary operation"),
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
              Expanded(
                child: _selectedImages.isEmpty
                    ? const Center(
                        child: Text('No images selected'),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
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
                                    width: double.infinity,
                                    height: double.infinity,
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
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
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
                        decoration: InputDecoration(
                        
                          fillColor: primaryColor.withAlpha(30),
                          hintText: 'Price',
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Text(
                              'Enter the price of your product in Ghana Cedis (GH₵)'),
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
                        leading: Text('GH₵'),
                        title: Text('Select Keywords'),
                        subtitle: Text("Keywords help users find your service"),
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
                        maxLines: 5,
                        decoration: InputDecoration(
                          fillColor: primaryColor.withAlpha(30),
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
                        filled: true,
                        fillColor: primaryColor.withAlpha(30),
                      ),
                      backgroundColor: Colors.white),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColor.withAlpha(30),
                    enabledBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  initialCountryCode: 'GH',
                  onChanged: (phone) {
                    log(phone.completeNumber);
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: ElevatedButton(
                  style: loading
                      ? Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(loadingColor),
                          )
                      : null,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        /// TODO: Post product save to Firestore
                      
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
                      : const Text("Post Product"),
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
