import 'package:assist/features/welcome/controllers/home_controller.dart';
import 'package:assist/utils/theme/theme_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static setupDependencies() {
    Get.put(ThemeController());
    Get.put(HomeController());
  }
}
