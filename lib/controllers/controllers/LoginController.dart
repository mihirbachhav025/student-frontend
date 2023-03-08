import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final String customToken = "your_custom_token_here";
  // String identityToken;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await _createIdentityToken();
  // }

  // Future<void> _createIdentityToken() async {
  //   try {
  //     // Sign in with the custom token
  //     final UserCredential userCredential = await _auth.signInWithCustomToken(customToken);

  //     // Get the user's ID token
  //     final idTokenResult = await userCredential.user.getIdToken();

  //     // Set the identity token to the ID token string
  //     identityToken = idTokenResult.token;

  //     // Navigate to the home screen
  //     Get.offAll(() => HomeScreen());
  //   } catch (e) {
  //     print('Error creating identity token: $e');
  //     // Handle error
  //   }
  // }
}