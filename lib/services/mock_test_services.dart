import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/mock_test_model.dart';
import '../services/firestore_ref_service.dart';

import '../shared_preference/mock_test_preferences.dart';
import '../utils/toast_snack_bar.dart';

class MockTestServices {
  late final FirestoreRefService _firestoreRefService;

  MockTestServices() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<List<MockTestModel>> fetchMockTestList(String uid) async {
    try {
      QuerySnapshot<MockTestModel> snapshot =
          await _firestoreRefService.getMockTestRef(uid).get();

      List<MockTestModel> mockTestList = snapshot.docs
          .map((doc) => MockTestModel.fromJson(doc.data().toJson()))
          .toList();
      return mockTestList;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
    return [];
  }

  Future<void> updateTestStatus(
      String uid, String testId, String newStatus) async {
    try {
      // Update the test status in Firestore
      await _firestoreRefService.getMockTestRef(uid).doc(testId).update({
        'status': newStatus,
      });

      // Fetch the updated test document using withConverter
      DocumentSnapshot<MockTestModel> updatedTestSnapshot =
          await _firestoreRefService.getMockTestRef(uid).doc(testId).get();

      if (updatedTestSnapshot.exists) {
        MockTestModel mockTestModel = updatedTestSnapshot.data()!;

        await MockTestPreferences()
            .saveMockTest(mockTestModel, mockTestModel.id);

        // Reload all tests after updating status (if needed)
        // loadAllTests();
      } else {
        AppSnackBar.error("Test not found.");
      }
    } catch (e) {
      AppSnackBar.error("Failed to update test status: $e");
    }
  }

  Future<void> uploadMockTest(
      String uid, String testId, MockTestModel mockTestModel) async {
    try {
      _firestoreRefService.getMockTestRef(uid).doc(testId).set(mockTestModel);
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
  }
}
