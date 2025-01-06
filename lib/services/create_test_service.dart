import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/all_ques_model.dart';
import '../models/mock_test_model.dart';
import '../services/firestore_ref_service.dart';

import '../utils/toast_snack_bar.dart';

class CreateTestService {
  late final FirestoreRefService _firestoreRefService;

  CreateTestService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<String> createTest(String uid, List<AllQuestionModel> questionList,
      MockTestModel mockTestModel) async {
    try {
      final docRef = _firestoreRefService.getMockTestRef(uid).doc();
      await docRef.set(mockTestModel);

      // await docRef.update({'id': docRef.id});
      MockTestModel updatedMock = mockTestModel.copyWith(id: docRef.id);
      await docRef.set(updatedMock);
      for (var question in questionList) {
        await _firestoreRefService
            .getUserTestQuestionRef(uid, docRef.id)
            .doc(question.id)
            .set(question);
      }
      AppSnackBar.success("Congrats!! Test created successfully.");
      return docRef.id;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
    return "";
  }
}
