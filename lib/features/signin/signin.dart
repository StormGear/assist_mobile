import 'package:assist/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('tw'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.SignIn).tr(),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('SignIn').tr(),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  child: const Text(LocaleKeys.SignIn).tr()),
              ElevatedButton(
                onPressed: () async {
                  await context.setLocale(const Locale('tw'));
                },
                child: const Text('twi'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context.setLocale(const Locale('en', 'US'));
                },
                child: const Text('eng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
