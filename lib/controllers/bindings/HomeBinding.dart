import 'package:get/get.dart';

import '../controllers/HomeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register the LoginController
    //   Get.lazyPut(() => HomeController());
  }
}
