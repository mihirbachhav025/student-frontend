import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:student_app/controllers/controllers/LoginController.dart';
import 'package:student_app/controllers/controllers/StudentDataController.dart';
import 'package:student_app/utils/sharepref.dart';

import '../controllers/controllers/LocationController.dart';
import '../widgets/LectureCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool light0 = false;
  String userId = SharedPrefs.getUserId()!;
  Logger logger = Logger();
  final studentDataController =
      Get.put<StudentDataController>(StudentDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Attendance')),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                width: MediaQuery.of(context).size.width * .90,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                height: 75,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          'Give Location Access',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Switch(
                            activeColor: Colors.white,
                            value: light0,
                            onChanged: (bool value) {
                              final locationController =
                                  Get.find<LocationController>();
                              locationController.startLocationRecording(userId);
                              setState(() {
                                light0 = value;
                              });
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: double.infinity,
            child: Obx(() {
              if (studentDataController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<String> lectureList = studentDataController.lecturePaths;
                return ListView.builder(
                    itemCount: studentDataController.lecturePaths.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return LectureCard(path: lectureList[index]);
                    });
              }
            }),
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Obx(() {
          if (studentDataController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  currentAccountPicture: Image.network(
                      'https://th.bing.com/th?id=ODL.b888a41f9a8eb720963897b5e5430fc1&w=100&h=100&c=12&pcl=faf9f7&o=6&dpr=1.3&pid=13.1'),
                  accountName: Text(
                      'Welcome  ${studentDataController.studentData['Firstname']} ${studentDataController.studentData['Lastname']} \n  '),
                  accountEmail: Text(
                      'Division :${studentDataController.studentData['Division']}  Rollno: ${studentDataController.studentData['RollNo']}'),
                ),
                ListTile(
                  title: const Text('View Timetable'),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const Timetable()),
                    // );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('View Attendance'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () async {
                    final loginController = Get.find<LoginController>();
                    await loginController.logout();
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
