import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/post-page/carousel.dart';
import 'package:assist/messages/chat_screen.dart';
import 'package:assist/reviews/review_card.dart';
import 'package:assist/reviews/review_model.dart';
import 'package:assist/reviews/reviews_page.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/utils/function_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    super.key,
    required this.postData,
  });

  final Map<String, dynamic> postData;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Map<dynamic, dynamic> userDetails = {};
  List<dynamic> reviews = [];

  @override
  void initState() {
    super.initState();
    _getUserReviews();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    try {
      userDetails = await DatabaseController.instance
          .retrieveUserDataWithID(widget.postData['user_id'] ?? 'user_id');
      log('User details fetched: $userDetails');
      if (mounted) {
        setState(() {
          userDetails = userDetails;
        });
      }
    } catch (e) {
      log('Error fetching user details: $e');
    }
  }

  Future<void> _getUserReviews() async {
    try {
      reviews = await DatabaseController.instance
          .getReviewsWithID(widget.postData['user_id'] ?? 'user_id');
      if (mounted) {
        setState(() {
          reviews = reviews;
        });
      }
      log('User reviews fetched: $reviews');
    } catch (e) {
      log('Error fetching user reviews: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postData['category'] ?? 'Category'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(imgList: widget.postData['images'] ?? []),
            Gap(10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.postData['business_name'] ?? 'Business Name',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor),
                      Text(
                        widget.postData['region'] ?? 'Location',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                                color: Colors.grey.shade200,
                                shape: CircleBorder()),
                            child: IconButton(
                                onPressed: () async {
                                  try {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        widget.postData['phone'] ??
                                            '+233503230804');
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                icon: const Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                  // size: 30,
                                )),
                          ),
                          Gap(10),
                          // dbController.hasCallSupport.value
                          //     ?
                          Text('Phone Call')
                          // : const Text(
                          //     'Calling not supported'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   decoration: ShapeDecoration(
                          //       color: Colors.grey.shade200,
                          //       shape: CircleBorder()),
                          //   child: IconButton(
                          //       onPressed: () async {
                          //         try {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) => ChatScreen(
                          //                 conversationId:
                          //                     widget.postData['user_id'] ??
                          //                         'user_id',
                          //               ),
                          //             ),
                          //           );
                          //         } catch (e) {
                          //           log(e.toString());
                          //         }
                          //       },
                          //       icon: const Icon(Icons.chat, color: primaryColor
                          //           // size: 30,
                          //           ))
                          //           ,
                          // ),
                          // Gap(10),
                          // Text('Chat')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Key Services",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Gap(10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _buildKeyservices(context,
                        items: widget.postData['keywords'] ??
                            ['Keyword 1', 'Keyword 2']),
                  ),
                ],
              ),
            ),
            Gap(15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(10),
                    Text(
                      widget.postData['description'] ??
                          'Description of the business',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Gap(15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Profile",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gap(10),
                    Row(
                      children: [
                        // CircleAvatar(
                        //     radius: 30,
                        //     backgroundColor: Colors.grey,
                        //     backgroundImage: userDetails['profile_url'] !=
                        //                 null ||
                        //             userDetails['profile_url'] != '' ||
                        //             userDetails['profile_url'] != 'null'
                        //         ? CachedNetworkImageProvider(
                        //             userDetails['profile_url'],
                        //           )
                        //         : AssetImage("assets/images/logo/favicon.png")),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/images/logo/favicon.png")),
                        Gap(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${userDetails['firstname']} ${userDetails['lastname']}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Gap(5),
                            userDetails['created_at'] != null
                                ? Text(
                                    computeDateDifference(
                                      DateTime.parse(convertFirestoreObjects(
                                          userDetails['created_at'])),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reviews & Ratings (${reviews.length})",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() => ReviewsPage(
                                    revieweeId: userDetails['user_id'],
                                    reviews: reviews,
                                  ));
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(color: primaryColor),
                            ))
                      ],
                    ),
                    Gap(10),
                    Column(
                      children: [
                        if (reviews.isNotEmpty)
                          ReviewCard(
                              review: ReviewModel(
                            avatarUrl: userDetails['profile_url'] ?? '',
                            author: userDetails['firstname'] ?? 'User',
                            rating: 5,
                            date: DateTime.parse(convertFirestoreObjects(
                                reviews[0]['created_at'])),
                            comment: 'Review message',
                          )),
                        Gap(10),
                        SizedBox(
                          width: size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => WriteReviewDialog(
                                  revieweeId: userDetails['user_id'],
                                ),
                              );
                            },
                            child: const Text("Write a Review"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildKeyservices(BuildContext context,
    {List<dynamic> items = const []}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 4,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      String item = items[index];
      return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    },
  );
}

String computeDateDifference(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  final months = (difference.inDays / 30).floor();
  final remainingDays = difference.inDays % 30;

  if (months > 0) {
    return '$months months $remainingDays days ago';
  } else {
    return '$remainingDays days ago';
  }
}
