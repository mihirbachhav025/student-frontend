import 'package:get/get.dart';

import '../controllers/LoginController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Register the LoginController
    Get.lazyPut(() => LoginController());
  }
}
