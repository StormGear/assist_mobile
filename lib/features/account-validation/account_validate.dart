import 'package:assist/common_widgets/common_button.dart';
import 'package:assist/common_widgets/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AccountValidation extends StatefulWidget {
  const AccountValidation({super.key});

  @override
  State<AccountValidation> createState() => _AccountValidationState();
}

class _AccountValidationState extends State<AccountValidation> {
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
              Text(
                'Ghana Card Number',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: primaryColor.withAlpha(30),
                    hintText: 'Enter your ID Number',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Gap(20),
              SizedBox(
                  width: size.width * 0.8,
                  child: CommonButton(text: 'Save Changes', onPressed: () {})),
              Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
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
                  child: CommonButton(text: 'Save Changes', onPressed: () {})),
            ],
          ),
        )),
      ),
    );
  }
}
