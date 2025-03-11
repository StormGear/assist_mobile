import 'package:assist/reviews/demo_values.dart';
import 'package:assist/reviews/review_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Reviews"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Gap(10),
          SizedBox(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Write a Review"),
            ),
          ),
          Gap(10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: demoReviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ReviewCard(
                    review: demoReviews[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
