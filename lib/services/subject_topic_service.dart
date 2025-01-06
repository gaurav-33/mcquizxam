import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/subject_model.dart';
import '../services/firestore_ref_service.dart';
import '../utils/toast_snack_bar.dart';

class SubjectTopicService {
  late final FirestoreRefService _firestoreRefService;

  SubjectTopicService() {
    _firestoreRefService = Get.find<FirestoreRefService>();
  }

  Future<List<SubjectModel>> fetchSubjectList() async {
    try {
      QuerySnapshot<SubjectModel> snapshot =
          await _firestoreRefService.subjectCollectionRef.get();

      List<SubjectModel> subjectList = snapshot.docs
          .map((doc) => SubjectModel.fromJson(doc.data().toJson()))
          .toList();
      return subjectList;
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred. ${e.toString()}");
      }
    }
    return [];
  }

  Future<List<TopicModel>> fetchTopicList(String subjectId) async {
    try {
      QuerySnapshot<TopicModel> snapshot =
          await _firestoreRefService.getTopicRef(subjectId).get();
      List<TopicModel> topicList = snapshot.docs
          .map((doc) => TopicModel.fromJson(doc.data().toJson()))
          .toList();
      return topicList;
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
