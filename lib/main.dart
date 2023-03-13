import 'package:flutter/material.dart';
import 'package:student_app/screens/home_screen.dart';
import 'package:student_app/view/login_page.dart';
import 'package:get/get.dart';

import 'controllers/bindings/HomeBinding.dart';
import 'controllers/bindings/LoginBinding.dart';
import 'utils/sharepref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NextGen Attendance Student',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/homeScreen',
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
