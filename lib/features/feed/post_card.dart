import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/feed/demo_values.dart';
import 'package:assist/features/post-page/post_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleTheme = Theme.of(context).textTheme.bodySmall!;
    final TextStyle summaryTheme = Theme.of(context).textTheme.bodySmall!;
    final String title = DemoValues.postTitle;
    final String summary = DemoValues.postSummary;
    return GestureDetector(
      onTap: () {
        Get.to(
          () => PostPage(),
        );
      },
      child: AspectRatio(
        aspectRatio: 8 / 3,
        child: Card(
            elevation: 2,
            color: Colors.grey[100],
            child: Row(children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    DemoValues.postImage,
                    height: double.infinity,
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 5.0, right: 5.0),
                        child: Text(title,
                            style: titleTheme.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      Gap(5),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text.rich(
                            TextSpan(
                              text: summary,
                              style: summaryTheme,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Gap(5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: primaryColor),
                          Text(
                            'Location',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                        ],
                      ),
                      Gap(5),
                    ],
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
