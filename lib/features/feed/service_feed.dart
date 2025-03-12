import 'package:assist/features/feed/post_card.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Feed"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: PostCard(),
          );
        },
      ),
    );
  }
}
