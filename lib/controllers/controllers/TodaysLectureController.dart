import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodayLectureContolller extends GetxController {
  RxMap lecturesByProfessor = {}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final databaseref = FirebaseDatabase.instance.ref();
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}
