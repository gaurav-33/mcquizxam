import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/all_ques_model.dart';
import '../services/firestore_ref_service.dart';

import '../utils/toast_snack_bar.dart';

class RandomQuestionService {
  late final FirestoreRefService _firestoreRefService;

  RandomQuestionService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<List<AllQuestionModel>> getRandomQuestion(
      String subjectId, String topicId, int limit) async {
    try {
      QuerySnapshot<AllQuestionModel> totalSnapshot =
          await _firestoreRefService.getAllQuesRef(subjectId, topicId).get();
      final totalDocs = totalSnapshot.size;
      if (totalDocs == 0) {
        AppSnackBar.error("Question list isEmpty for this topic.");
        return [];
      }

      final random = Random();
      final randomOffset =
          totalDocs > limit ? random.nextInt(totalDocs - limit) : 0;
      QuerySnapshot<AllQuestionModel> snapshot = await _firestoreRefService
          .getAllQuesRef(subjectId, topicId)
          .orderBy(FieldPath.documentId)
          .startAt([totalSnapshot.docs[randomOffset].id])
          .limit(limit)
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
