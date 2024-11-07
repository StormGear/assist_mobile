import 'package:assist/features/onboarding/onboarding_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Get an instance of the HomeController
  static HomeController get instance => Get.find();

  // Create a RxInt to hold the current page value
  final RxInt currentPage = 0.obs;

  // Create a list of OnBoard objects
  final List<OnBoard> demoData = [
    OnBoard(
      imageUrl: 'assets/images/onboarding/coffee_break.svg',
      title: "Find Skilled Artisans in your City",
      description:
          "Severals artisans are available in your city to help you with your tasks.",
    ),
    OnBoard(
      imageUrl: 'assets/images/onboarding/todo.svg',
      title: "Fastest Way To Book Great Artisans",
      description:
          "Book an artisan in less than 5 minutes and get your task done.",
    ),
    OnBoard(
      imageUrl: 'assets/images/onboarding/workers.svg',
      title: "Make Informed Decisions when Hiring Artisans",
      description:
          "View ratings and reviews from other customers before hiring an artisan.",
    ),
  ];
}
