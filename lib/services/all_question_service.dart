import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/all_ques_model.dart';
import '../services/firestore_ref_service.dart';

import '../utils/toast_snack_bar.dart';

class AllQuestionService {
  late final FirestoreRefService _firestoreRefService;

  AllQuestionService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<List<AllQuestionModel>> fetchAllQuestion(
      String uid, String mockTestId) async {
    try {
      QuerySnapshot<AllQuestionModel> snapshot = await _firestoreRefService
          .getUserTestQuestionRef(uid, mockTestId)
          .get();

      List<AllQuestionModel> questionList = snapshot.docs
          .map((doc) => AllQuestionModel.fromJson(doc.data().toJson()))
          .toList();

      return questionList;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
    return [];
  }
}
