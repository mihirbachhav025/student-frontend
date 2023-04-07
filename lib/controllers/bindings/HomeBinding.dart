import 'package:get/get.dart';
import 'package:student_app/controllers/controllers/LocationController.dart';
import 'package:student_app/controllers/controllers/LoginController.dart';

import '../controllers/StudentDataController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register the LoginController
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => StudentDataController());
  }
}
