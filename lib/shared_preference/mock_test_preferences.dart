import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/mock_test_model.dart';

class MockTestPreferences {
  static const _mockTestKey = "MOCK_TEST_";
  static const _currentTestKey = "currentTest";

  Future<void> saveMockTest(
      MockTestModel mockTestModel, String mockTestId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String mockData = jsonEncode(mockTestModel.toJson());
    await pref.setString("$_mockTestKey$mockTestId", mockData);
  }

  Future<MockTestModel?> getMockTest(String mockTestId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? mapData = pref.getString("$_mockTestKey$mockTestId");
    if (mapData == null) {
      return null;
    }
    return MockTestModel.fromJson(jsonDecode(mapData));
  }

  Future<void> deleteMockTest(String mockTestId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("$_mockTestKey$mockTestId");
  }

  Future<List<MockTestModel>> getAllMockTest() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final keys = pref.getKeys().where((key) => key.startsWith(_mockTestKey));
    final mockTestList = <MockTestModel>[];
    for (var key in keys) {
      final mockTestJson = pref.getString(key);
      if (mockTestJson != null) {
        final mockTestMap = await jsonDecode(mockTestJson);
        mockTestList.add(MockTestModel.fromJson(mockTestMap));
      }
    }
    return mockTestList;
  }

  Future<void> deleteAllMockTest() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final keys = pref.getKeys().where((key) => key.startsWith(_mockTestKey));
    for (var key in keys) {
      await pref.remove(key);
    }
  }

// Future<void> saveCurrentTest(MockTestModel currentTestModel) async{
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String currentTestModelString = jsonEncode(currentTestModel).toString();
//   await pref.setString(_currentTestKey, currentTestModelString);
// }
//
// Future<MockTestModel?> getCurrentTest() async{
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   String? mapData = pref.getString(_currentTestKey);
//   if(mapData == null){
//     return null;
//   }else{
//     return MockTestModel.fromJson(jsonDecode(mapData));
//   }
// }
}
