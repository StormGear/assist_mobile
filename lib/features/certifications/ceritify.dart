import 'package:flutter/material.dart';

class GetCertified extends StatefulWidget {
  const GetCertified({super.key});

  @override
  State<GetCertified> createState() => _GetCertifiedState();
}

class _GetCertifiedState extends State<GetCertified> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Get Certified"),
      ),
    );
  }
}
