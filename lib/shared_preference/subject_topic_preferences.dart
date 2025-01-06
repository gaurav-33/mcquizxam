import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/subject_model.dart';

class SubjectTopicPreferences {
  static const _subjectKey = "SUBJECT";
  static const _topicKey = "TOPIC";

  static Future<void> saveSubjectList(
      List<SubjectModel> subjectModelList) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> subjectDataList = subjectModelList
        .map((subject) => jsonEncode(subject.toJson()))
        .toList();
    await pref.setStringList(_subjectKey, subjectDataList);
  }

  static Future<List<SubjectModel>> getSubjectList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? subjectData = pref.getStringList(_subjectKey);
    return subjectData == null
        ? []
        : subjectData
            .map((data) => SubjectModel.fromJson(jsonDecode(data)))
            .toList();
  }

  static Future<void> deleteSubjectList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(_subjectKey);
  }

  static Future<void> saveTopicList(
      List<TopicModel> topicModelList, String subjectId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> topicDataList =
        topicModelList.map((subject) => jsonEncode(subject.toJson())).toList();
    await pref.setStringList("${_topicKey}_$subjectId", topicDataList);
  }

  static Future<List<TopicModel>> getTopicList(String subjectId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? topicData = pref.getStringList("${_topicKey}_$subjectId");
    return topicData == null
        ? []
        : topicData
            .map((data) => TopicModel.fromJson(jsonDecode(data)))
            .toList();
  }

  static Future<void> deleteTopicList(String subjectId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("${_topicKey}_$subjectId");
  }
}
