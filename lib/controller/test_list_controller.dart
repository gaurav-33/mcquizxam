import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../models/mock_test_model.dart';
import '../services/mock_test_services.dart';
import '../shared_preference/mock_test_preferences.dart';
import '../utils/toast_snack_bar.dart';

class TestListController extends GetxController {
  RxList<MockTestModel> mockTestList = <MockTestModel>[].obs;
  RxList<MockTestModel> resumeMockTestList = <MockTestModel>[].obs;
  RxList<MockTestModel> presentMockTestList = <MockTestModel>[].obs;
  RxList<MockTestModel> previousMockTestList = <MockTestModel>[].obs;
  RxBool isLoading = false.obs;
  late final MockTestServices _mockTestServices;
  late final HomeController _homeController;

  @override
  void onInit() {
    super.onInit();
    _mockTestServices = Get.find<MockTestServices>();
    _homeController = Get.find<HomeController>();
    loadAllTests();
  }

  Future<void> loadAllTests() async {
    // await MockTestPreferences().deleteAllMockTest();
    isLoading.value = true; // Start loading
    try {
      // Step 1: Load tests from local storage
      final localTests = await MockTestPreferences().getAllMockTest();
      if (localTests.isNotEmpty) {
        // Populate lists from local storage
        mockTestList.value = localTests;

        clearAllList();

        for (var test in mockTestList) {
          switch (test.status) {
            case "ongoing":
              resumeMockTestList.add(test);
              break;
            case "incomplete":
              presentMockTestList.add(test);
              break;
            case "completed":
              previousMockTestList.add(test);
              break;
          }
        }
      }

      // Step 2: Fetch tests from server and merge with local data
      final allFetchedTest =
          await _mockTestServices.fetchMockTestList(_homeController.uid.value);

      // Merge server and local data intelligently
      for (var fetchedTest in allFetchedTest) {
        final existingTest = mockTestList
            .firstWhereOrNull((localTest) => localTest.id == fetchedTest.id);

        if (existingTest == null) {
          // Add new test from server
          mockTestList.add(fetchedTest);
          await MockTestPreferences().saveMockTest(fetchedTest, fetchedTest.id);
        } else if (existingTest.updatedAt.isBefore(fetchedTest.updatedAt)) {
          // Update test if server data is newer
          mockTestList[mockTestList.indexOf(existingTest)] = fetchedTest;
          await MockTestPreferences().saveMockTest(fetchedTest, fetchedTest.id);
        }
      }

      // Re-categorize tests
      clearAllList();

      mockTestList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      for (var test in mockTestList) {
        switch (test.status) {
          case "ongoing":
            resumeMockTestList.add(test);
            break;
          case "incomplete":
            presentMockTestList.add(test);
            break;
          case "completed":
            previousMockTestList.add(test);
            break;
        }
      }
    } catch (e, stacktrace) {
      AppSnackBar.error("Failed to load tests: $e");
      debugPrint("Error loading tests: $e");
      debugPrint("Stacktrace: $stacktrace");

      mockTestList.clear();
      clearAllList();
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  void clearAllList() {
    resumeMockTestList.clear();
    presentMockTestList.clear();
    previousMockTestList.clear();
  }
}
