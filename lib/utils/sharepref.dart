import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences instance;
  static const String _customToken = 'customToken';
  static const String _identityToken = 'identityToken';
  static const String _userId = 'userId';
  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();
  static Future<bool> setCustomToken(String value) =>
      instance.setString(_customToken, value);
  static String? getCustomToken() => instance.getString(_customToken);
  static Future<bool> setIdentityToken(String value) =>
      instance.setString(_identityToken, value);
  static String? getIdentityToken() => instance.getString(_identityToken);
  static Future<bool> setUserId(String value) =>
      instance.setString(_userId, value);
  static String? getUserId() => instance.getString(_userId);
}
