import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:student_app/utils/internetcheck.dart';

class LoginController extends GetxController {
  late ConnectionUtil _connectionUtil = ConnectionUtil.getInstance();
  Dio dio = Dio();
  @override
  void onInit() {
    // TODO: implement onInit
    _connectionUtil.initialize();
    super.onInit();
  }

  Future<void> login(String userId, String password) async {
    print('=================================jkjkjk=========');

    if (_connectionUtil.hasConnection) {
      try {
        print("aaaaaaaaaaaaaaaa");
        final response = await dio.post(
          'http://192.168.5.102:3000/api/v1/login',
          //in backend its username change afterwards
          data: {"username": userId, "password": password},
        );
        print(response.data.runtimeType);
        final data = response.data as Map<String, dynamic>;
        final String msg = data['msg'];
        print('===========xxxxxxxxxx========');
        print(msg);
      } catch (e) {
        print(e.toString());
        Get.snackbar('Login failed', 'Server Error');
      }
    } else {
      Get.snackbar('Login failed', 'No internet Connection');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dio.close();
    _connectionUtil.connectionChangeController.close();
    super.dispose();
  }
  //  final FirebaseAuth _auth = FirebaseAuth.instance;
  //  final String customToken = "your_custom_token_here";
  //  String identityToken;
  // @override
  //  void onInit() async {
  //    super.onInit();
  //    await _createIdentityToken();
  //  }
  // Future<void> _createIdentityToken() async {
  //    try {
  //      // Sign in with the custom token
  //      final UserCredential userCredential = await _auth.signInWithCustomToken(customToken);
  //     // Get the user's ID token
  //      final idTokenResult = await userCredential.user.getIdToken();
  //     // Set the identity token to the ID token string
  //      identityToken = idTokenResult.token;
  //     // Navigate to the home screen
  //      Get.offAll(() => HomeScreen());
  //    } catch (e) {
  //      print('Error creating identity token: $e');
  //      // Handle error
  //    }
  //  }
}
