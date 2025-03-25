import 'dart:developer';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class AccountValidation extends StatefulWidget {
  const AccountValidation({super.key});

  @override
  State<AccountValidation> createState() => _AccountValidationState();
}

class _AccountValidationState extends State<AccountValidation> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
          "Account Validation",
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
              Row(
                children: [
                  Text(
                    'Ghana Card Number',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Gap(10),
              TextFormField(
                decoration: InputDecoration(
                  fillColor: primaryColor.withAlpha(30),
                  hintText: 'Enter your ID Number',
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      try {
                        /// TODO: Save Ghana Card Number to Firestore
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
                      : const Text("Save Changes"),
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'Digital Address',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(50),
              SizedBox(
                width: size.width * 0.8,
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
                        /// TODO: Save Digital Address to Firestore
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
