import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
import 'package:assist/features/post-page/carousel.dart';
import 'package:assist/reviews/review_card.dart';
import 'package:assist/reviews/review_model.dart';
import 'package:assist/reviews/reviews_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Category Selected"),
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
            ImageCarousel(),
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
                      "Business Name",
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
                        'Location',
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
                                        '+233538966851');
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
                          Container(
                            decoration: ShapeDecoration(
                                color: Colors.grey.shade200,
                                shape: CircleBorder()),
                            child: IconButton(
                                onPressed: () async {
                                  try {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        '+233538966851');
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                icon: const Icon(Icons.chat, color: primaryColor
                                    // size: 30,
                                    )),
                          ),
                          Gap(10),
                          Text('Chat')
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
                    child: _buildKeyservices(context, items: [
                      'Service 1',
                      'Service 2',
                      'Service 3',
                      'Service 4',
                      'Service 5',
                      'Service 6',
                    ]),
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
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80')),
                        Gap(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name of person'),
                            Gap(5),
                            Text(
                                computeDateDifference(
                                    DateTime.parse('2025-01-01')),
                                style: Theme.of(context).textTheme.bodySmall),
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
                          "Reviews & Ratings (0)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() => ReviewsPage());
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
                        ReviewCard(
                            review: ReviewModel(
                          avatarUrl:
                              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                          author: 'Name of person',
                          rating: 3,
                          date: DateTime.parse('2025-01-01'),
                          comment: 'Review message',
                        )),
                        Gap(10),
                        SizedBox(
                          width: size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const WriteReviewDialog(),
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
    {List<String> items = const []}) {
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
