import 'dart:convert';

import '../models/test_config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestConfigPreferences {
  static const _testConfigKey = "TEST_CONFIG";

  static Future<void> saveTestConfig(TestConfigModel testConfigModel) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String testConfigData = jsonEncode(testConfigModel.toJson());
    await pref.setString(_testConfigKey, testConfigData);
  }

  static Future<TestConfigModel?> getTestConfig() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? testConfigData = pref.getString(_testConfigKey);
    if (testConfigData == null) {
      return null;
    }
    Map<String, dynamic> testConfigMap = jsonDecode(testConfigData);
    return TestConfigModel.fromJson(testConfigMap);
  }

  static Future<void> deleteTestConfig() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_testConfigKey);
  }
}
