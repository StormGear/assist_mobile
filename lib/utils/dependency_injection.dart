import 'package:assist/features/welcome/controllers/home_controller.dart';
import 'package:assist/services/database/database_controller.dart';
import 'package:assist/services/database/user_details_controller.dart';
import 'package:assist/services/storage/storage_controller.dart';
import 'package:assist/utils/theme/theme_controller.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static setupDependencies() {
    Get.put(ThemeController());
    Get.put(HomeController());
    Get.put(DatabaseController());
    Get.put(UserDetails());
    Get.put(StorageController());
    Get.put(StorageController());
  }
}
