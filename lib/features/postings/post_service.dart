import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class PostService extends StatefulWidget {
  const PostService({super.key});

  @override
  State<PostService> createState() => _PostServiceState();
}

class _PostServiceState extends State<PostService> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('Category'),
                  subtitle:
                      Text("Select a category under which your service falls"),
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
                    Image.asset('assets/images/postings/add_photo.png'),
                  ],
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
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
                    Text('Select keywords that best describe your service'),
                  ],
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  title: Text('Select Keywords'),
                  subtitle: Text("Keywords help users find your service"),
                  trailing: Icon(Icons.arrow_forward_ios, color: primaryColor),
                  tileColor: primaryColor.withAlpha(30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
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
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                    'Kindly provide a detailed description of your service, doing so will help users understand what you offer better'),
              ),
              Gap(20),
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
                        /// TODO: Post service save to Firestore
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
