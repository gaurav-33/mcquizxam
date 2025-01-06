import 'dart:convert';

import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _userKey = "USER_";

  static Future<void> saveUser(UserModel user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userData = jsonEncode(user.toSharedPrefJson());
    await pref.setString(_userKey, userData);
  }

  static Future<UserModel?> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userData = pref.getString(_userKey);
    if (userData == null) {
      return null;
    }
    // Map<String, dynamic> userMap = jsonDecode(userData);
    return UserModel.fromSharedPrefJson(jsonDecode(userData));
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
