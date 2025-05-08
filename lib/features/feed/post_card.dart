import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/post-page/post_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.postData});

  final Map<String, dynamic> postData;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
    log('PostCard initialized with data: ${widget.postData}');
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.bodySmall!;
    final TextStyle summaryTheme = Theme.of(context).textTheme.bodySmall!;
    // final String title = DemoValues.postTitle;
    // final String summary = DemoValues.postSummary;
    final String title = widget.postData['business_name'] ?? 'Post Title';
    final String summary = widget.postData['description'] ?? 'Post Summary';
    final String imageUrl =
        widget.postData['images']?[0] ?? "https://placehold.co/600x400.png";
    final String location = widget.postData['region'] ?? 'Location';
    final String rating = widget.postData['rating'] ?? '5';
    return GestureDetector(
      onTap: () {
        Get.to(
          () => PostPage(postData: widget.postData),
        );
      },
      child: AspectRatio(
        aspectRatio: 8 / 3,
        child: Card(
            elevation: 5,
            color: Colors.white,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ClipRRect(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     child: Image.asset(
                  //       DemoValues.postImage,
                  //       height: double.infinity,
                  //     )),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        imageUrl,
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(title,
                                style: titleTheme.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          Gap(2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on,
                                  color: primaryColor, size: 18),
                              Text(
                                location,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Gap(2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Gap(5),
                              Text(
                                rating,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Gap(2),
                          Text.rich(
                            TextSpan(
                              text: summary,
                              style: summaryTheme,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
