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
      title: "Find Best Musicians All Around Your City",
      description:
          "Thousands of musicians around you are waiting to rock your event.",
    ),
    OnBoard(
      imageUrl: 'assets/images/onboarding/todo.svg',
      title: "Fastest Way To Book Great Musicians",
      description:
          "Find the perfect match to perform for your event and make the day remarkable.",
    ),
    OnBoard(
      imageUrl: 'assets/images/onboarding/workers.svg',
      title: "Find Top Sessions Pros For Your Event",
      description:
          "Find the perfect match to perform for your event and make the day remarkable.",
    ),
  ];
}
