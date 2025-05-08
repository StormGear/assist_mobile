import 'dart:developer';

import 'package:assist/common_widgets/constants/colors.dart';
// import 'package:assist/reviews/demo_values.dart';
import 'package:assist/reviews/review_card.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key, required this.reviews, this.revieweeId});
  final String? revieweeId;
  final List reviews;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      WriteReviewDialog(revieweeId: widget.revieweeId),
                );
              },
              child: const Text("Write a Review"),
            ),
          ),
          Gap(10),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ReviewCard(
                    review: widget.reviews[index],
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

/// Create a dialog to write a review and rate the service
class WriteReviewDialog extends StatefulWidget {
  const WriteReviewDialog({super.key, this.revieweeId});
  final String? revieweeId;

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  double rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Write a Review"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text("Rate the service"),
            ],
          ),
          const Gap(10),
          RatingBar.builder(
            glow: true,
            glowColor: primaryColor,
            initialRating: 0,
            itemSize: 30.0,
            minRating: 0,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
            itemBuilder: (context, index) {
              if (index < rating) {
                // Filled state
                return SvgPicture.asset(
                  'assets/images/reviews/star-filled.svg',
                  colorFilter: const ColorFilter.mode(
                    primaryColor,
                    BlendMode.srcIn,
                  ),
                );
              } else {
                // Unfilled state
                return SvgPicture.asset(
                  'assets/images/reviews/star-empty.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                );
              }
            },
            onRatingUpdate: (rating) {
              log("$rating");
              setState(() {
                this.rating = rating;
              });
            },
          ),
          const Gap(10),
          TextField(
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "Write your review here",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            // Submit the review
            try {
              log("Rating: $rating");
              var review = {
                "rating": rating,
                "reviewer_id": UserDetails.instance.getUserId,
                "reviewee_id": widget.revieweeId,
                "review": _reviewController,
                "created_at": DateTime.now()
              };
              // Save the review to the database
              await DatabaseController.instance.createReview(review);
              Fluttertoast.showToast(
                  msg: "Review submitted successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } catch (e) {
              log("Error: $e");
              Fluttertoast.showToast(
                  msg: "Failed to submit review",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Submit"),
        )
      ],
    );
  }
}
