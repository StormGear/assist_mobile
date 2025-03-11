import 'package:assist/features/feed/demo_values.dart';
import 'package:assist/features/post-page/post_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => PostPage(),
        );
      },
      child: AspectRatio(
        aspectRatio: 6 / 3,
        child: Card(
          elevation: 2,
          color: Colors.grey[200],
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                _Post(),
                Divider(color: Colors.grey),
                _PostDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(children: <Widget>[_PostImage(), _PostTitleAndSummary()]),
    );
  }
}

class _PostTitleAndSummary extends StatelessWidget {
  const _PostTitleAndSummary();

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.bodySmall!;
    final TextStyle summaryTheme = Theme.of(context).textTheme.bodySmall!;
    final String title = DemoValues.postTitle;
    final String summary = DemoValues.postSummary;

    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(title, style: titleTheme),
            SizedBox(height: 2.0),
            Text(summary, style: summaryTheme),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage();

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: Image.asset(DemoValues.postImage));
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _UserImage(),
        _UserNameAndEmail(),
        _PostTimeStamp(),
      ],
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  const _UserNameAndEmail();

  @override
  Widget build(BuildContext context) {
    final TextStyle nameTheme = Theme.of(context).textTheme.bodySmall!;
    final TextStyle emailTheme = Theme.of(context).textTheme.bodySmall!;

    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(DemoValues.userName, style: nameTheme),
            SizedBox(height: 2.0),
            Text(DemoValues.userEmail, style: emailTheme),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        backgroundImage: AssetImage(DemoValues.userImage),
      ),
    );
  }
}

class _PostTimeStamp extends StatelessWidget {
  const _PostTimeStamp();

  @override
  Widget build(BuildContext context) {
    final TextStyle timeTheme = Theme.of(context).textTheme.bodySmall!;
    return Expanded(
      flex: 2,
      child: Text(DemoValues.postTime, style: timeTheme),
    );
  }
}
