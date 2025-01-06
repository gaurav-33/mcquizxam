import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/test_config_model.dart';

import '../models/all_ques_model.dart';
import '../models/mock_test_model.dart';
import '../models/subject_model.dart';
import '../models/user_model.dart';

const String USER_COLLECT_REF = "users";
const String SUBJECT_COLLECT_REF = "subjects";
const String TOPIC_COLLECT_REF = "topics";
const String TESTCONFIF_COLLECT_REF = "test_configs";
const String ALLQUESTION_COLLECT_REF = "allquestions";
const String MOCK_TEST_COLLECT_REF = "user_tests";

class FirestoreRefService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<UserModel> userCollectionRef;
  late final CollectionReference<SubjectModel> subjectCollectionRef;
  late final CollectionReference<TestConfigModel> testConfigCollectionRef;
  late final CollectionReference<AllQuestionModel> allQuestionCollectionRef;
  late final CollectionReference<AllQuestionModel> userTestQuestionRef;

  FirestoreRefService() {
    userCollectionRef = _firestore.collection(USER_COLLECT_REF).withConverter(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (userdata, _) => userdata.toJson());

    subjectCollectionRef = _firestore
        .collection(SUBJECT_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                SubjectModel.fromJson(snapshots.data()!),
            toFirestore: (subData, _) => subData.toJson());

    testConfigCollectionRef = _firestore
        .collection(TESTCONFIF_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                TestConfigModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<TopicModel> getTopicRef(String subjectId) {
    return subjectCollectionRef
        .doc(subjectId)
        .collection(TOPIC_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                TopicModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<AllQuestionModel> getAllQuesRef(
      String subjectId, String topicId) {
    return subjectCollectionRef
        .doc(subjectId)
        .collection(TOPIC_COLLECT_REF)
        .doc(topicId)
        .collection(ALLQUESTION_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                AllQuestionModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<MockTestModel> getMockTestRef(String uid) {
    return userCollectionRef
        .doc(uid)
        .collection(MOCK_TEST_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                MockTestModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }

  CollectionReference<AllQuestionModel> getUserTestQuestionRef(
      String uid, String mockTestId) {
    return userCollectionRef
        .doc(uid)
        .collection(MOCK_TEST_COLLECT_REF)
        .doc(mockTestId)
        .collection(ALLQUESTION_COLLECT_REF)
        .withConverter(
            fromFirestore: (snapshots, _) =>
                AllQuestionModel.fromJson(snapshots.data()!),
            toFirestore: (data, _) => data.toJson());
  }
}
