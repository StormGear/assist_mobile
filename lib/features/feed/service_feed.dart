import 'package:assist/features/feed/post_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Feed"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(
          );
        },
      ),
    );
  }
}