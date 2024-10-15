import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Sign In Screen'),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/home');
                },
                child: const Text('home'))
          ],
        ),
      ),
    );
  }
}
