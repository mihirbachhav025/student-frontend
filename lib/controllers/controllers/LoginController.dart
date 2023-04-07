import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:student_app/utils/internetcheck.dart';
import 'package:student_app/utils/sharepref.dart';

import '../../screens/home_page.dart';

class LoginController extends GetxController {
  String _identityToken = '';
  String _customToken = '';
  late final ConnectionUtil _connectionUtil = ConnectionUtil.getInstance();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Dio dio = Dio();
  @override
  void onInit() {
    // TODO: implement onInit
    _connectionUtil.initialize();
    super.onInit();
  }

  Future<void> login(String userId, String password) async {
    if (_connectionUtil.hasConnection) {
      try {
        final response = await dio.post(
          'http://localhost:3000/api/v1/login/student',
          //in backend its username change afterwards
          data: {"userId": userId, "password": password},
        );
        print(response.data.runtimeType);
        if (response.statusCode != 200) {
          Get.snackbar('Login failed', 'Invalid Credentials');
          return;
        }
        final data = response.data as Map<String, dynamic>;
        final String msg = data['message'];
        _customToken = data['token'];

        await SharedPrefs.setCustomToken(_customToken);
        await SharedPrefs.setUserId(userId);
        await _createIdentityToken();
        print(msg);
      } catch (e) {
        print(e.toString());
        Get.snackbar('Login failed', 'Server Error');
      }
    } else {
      Get.snackbar('Login failed', 'No internet Connection');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.toNamed('/login');
      SharedPrefs.setCustomToken('');
      SharedPrefs.setIdentityToken('');
      SharedPrefs.setUserId('');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Logout failed', 'Error Ocurred');
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
  Future<void> _createIdentityToken() async {
    try {
      // Sign in with the custom token
      final UserCredential userCredential =
          await _auth.signInWithCustomToken(_customToken);
      // Get the user's ID token
      _identityToken = await userCredential.user!.getIdToken();
      await SharedPrefs.setIdentityToken(_identityToken);
      print(_identityToken);
      // Set the identity token to the ID token string
      // Navigate to the home screen
      Get.offAll(() => HomeScreen());
    } catch (e) {
      print('Error creating identity token: $e');
      // Handle error
    }
  }
}
