import 'package:get/get.dart';
import 'package:student_app/controllers/controllers/LocationController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register the LoginController
    Get.lazyPut(() => LocationController());
  }
}
