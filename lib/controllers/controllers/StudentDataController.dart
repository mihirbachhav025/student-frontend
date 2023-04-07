import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../utils/sharepref.dart';

class StudentDataController extends GetxController {
  RxBool isLoading = RxBool(true);
  var studentData = <String, String>{}.obs;
  Dio dio = Dio();
  Logger logger = Logger();
  List<String> lecturePaths = [];
  @override
  void onInit() {
    super.onInit();
    _fetchStudentData();
  }

  void _fetchStudentData() async {
    try {
      String token = SharedPrefs.getIdentityToken()!;
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(
        'http://localhost:3000/api/v1/students/getdetails',
      );
      if (response.statusCode == 200) {
        var _jsonData = response.data as Map<String, dynamic>;
        logger.d("hey1");
        var tempStudentData = <String, String>{};
        for (var key in _jsonData.keys) {
          if (_jsonData[key] == null) {
            tempStudentData[key] = '';
          } else {
            tempStudentData[key] = _jsonData[key].toString();
          }
        }
        studentData.value = tempStudentData;
        logger.d(studentData);
        logger.d("hey2");
        await fetchStudentLecture();
      } else {
        Get.snackbar('Fetching Student data failed', 'Invalid Credentials');
        throw Exception('Failed to load student data');
      }
    } catch (e) {
      throw Exception('Failed to connect to backend server: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStudentLecture() async {
    String currentyear = getYearString();
    String courseName = studentData['Cname']!;
    String academicYear = studentData['AcademicYear']!;
    String division = studentData['Division']!;
    String todaysDate = getTodayDate();
    final querySnapshot = await FirebaseFirestore.instance
        .collection(currentyear)
        .doc(courseName)
        .collection(academicYear)
        .doc(division)
        .collection(todaysDate)
        .get();
    logger.d(todaysDate);
    logger.d(currentyear + academicYear + division + courseName);
    logger.d(querySnapshot.docs);
    lecturePaths.clear();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      logger.d(doc.id);
      String sub = doc.get('sub');
      DocumentReference docRef = doc.reference;
      CollectionReference subjectSubCollectionRef = docRef.collection(sub);
      logger.d(subjectSubCollectionRef);
      String? userId = SharedPrefs.getUserId();
      DocumentSnapshot documentSnapshot =
          await subjectSubCollectionRef.doc(userId).get();
      logger.d(documentSnapshot.reference.path);
      DocumentReference lectureRef =
          FirebaseFirestore.instance.doc(documentSnapshot.reference.path);
      lecturePaths.add(documentSnapshot.reference.path);
      logger.d(lectureRef, "====================");
      logger.d(documentSnapshot.get('status'));
    }
    logger.d(lecturePaths.length);
    logger.d(lecturePaths[0]);
  }

  String getYearString() {
    DateTime now = DateTime.now();
    if (now.month < 6) {
      return '${now.year - 1}-${now.year}';
    } else {
      return '${now.year}-${now.year + 1}';
    }
  }

  String getTodayDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}-${now.year.toString()}";
    return formattedDate;
  }
}
