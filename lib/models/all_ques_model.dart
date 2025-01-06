class AllQuestionModel {
  AllQuestionModel({
    required this.id,
    required this.subjectId,
    required this.topicId,
    required this.topic,
    required this.subject,
    required this.questionText,
    required this.questionType,
    required this.options,
    required this.explanation,
    required this.difficulty,
  });

  final String id;
  final String subjectId;
  final String topicId;
  final String topic;
  final String subject;
  final String questionText;
  final String? questionType;
  final List<AllOptionModel> options;
  final String? explanation;
  final String? difficulty;

  factory AllQuestionModel.fromJson(Map<String, dynamic> json) {
    var optionsList = json['options'] as List;
    List<AllOptionModel> options =
        optionsList.map((i) => AllOptionModel.fromJson(i)).toList();

    return AllQuestionModel(
      id: json["id"],
      subjectId: json["subject_id"],
      topicId: json["topic_id"],
      topic: json["topic"],
      subject: json["subject"],
      questionText: json["question_text"],
      questionType: json["question_type"],
      options: options,
      explanation: json["explanation"],
      difficulty: json["difficulty"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_id": subjectId,
        "topic_id": topicId,
        "topic": topic,
        "subject": subject,
        "question_text": questionText,
        "question_type": questionType,
        "options": options.map((x) => x.toJson()).toList(),
        "explanation": explanation,
        "difficulty": difficulty,
      };
}

class AllOptionModel {
  AllOptionModel({
    required this.optionId,
    required this.text,
    required this.isCorrect,
  });

  final String optionId;
  final String text;
  final bool isCorrect;

  factory AllOptionModel.fromJson(Map<String, dynamic> json) {
    return AllOptionModel(
      optionId: json["option_id"],
      text: json["text"],
      isCorrect: json["is_correct"],
    );
  }

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "text": text,
        "is_correct": isCorrect,
      };
}
