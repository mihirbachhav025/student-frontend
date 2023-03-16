import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_app/controllers/service/location_service.dart';
import 'package:student_app/screens/login_page.dart';
import 'package:get/get.dart';

import 'controllers/bindings/HomeBinding.dart';
import 'controllers/bindings/LoginBinding.dart';
import 'controllers/controllers/LocationController.dart';
import 'firebase_options.dart';
import 'screens/home_page.dart';
import 'utils/sharepref.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.init();
  Get.put<LocationService>(LocationService(), permanent: true);
  Get.put(LocationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  String returnRoute() {
    final String? x = SharedPrefs.getIdentityToken();
    if (x != null && x.length != 0) {
      Logger logger = Logger();

      logger.d('=========Identity token here==========');
      logger.d("${SharedPrefs.getIdentityToken()}");
      logger.d(x.length);
      logger.d('====================');
      return '/homeScreen';
    } else {
      return '/login';
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NextGen Attendance Student',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: returnRoute(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/homeScreen',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
