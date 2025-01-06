class MockTestModel {
  final String id;
  final String title;
  final String subject;
  final String topic;
  final String description;
  final double duration;
  final double totalMarks;
  final double negativeMarksPerQuestion;
  final String status;
  final int numberOfQuestions;
  final double marksPerQuestion;
  final int questionAnswered;
  final int correctAnswers;
  final int incorrectAnswers;
  final double totalScore;
  final double durationLeft;
  final Map<String, String> userAnswerMap;
  final Map<String, String> originalAnswerMap;
  final int currentQuestionIndex;
  final DateTime updatedAt;

  MockTestModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.topic,
    required this.description,
    required this.duration,
    required this.totalMarks,
    required this.negativeMarksPerQuestion,
    required this.status,
    required this.numberOfQuestions,
    required this.marksPerQuestion,
    required this.questionAnswered,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalScore,
    required this.durationLeft,
    required this.userAnswerMap,
    required this.originalAnswerMap,
    required this.currentQuestionIndex,
    required this.updatedAt,
  });

  MockTestModel copyWith({
    String? id,
    String? title,
    String? subject,
    String? topic,
    String? description,
    double? duration,
    double? totalMarks,
    double? negativeMarksPerQuestion,
    String? status,
    int? numberOfQuestions,
    double? marksPerQuestion,
    int? questionAnswered,
    int? correctAnswers,
    int? incorrectAnswers,
    double? totalScore,
    double? durationLeft,
    Map<String, String>? userAnswerMap,
    Map<String, String>? originalAnswerMap,
    int? currentQuestionIndex,
    DateTime? updatedAt,
  }) {
    return MockTestModel(
        id: id ?? this.id,
        title: title ?? this.title,
        subject: subject ?? this.subject,
        topic: topic ?? this.topic,
        description: description ?? this.description,
        duration: duration ?? this.duration,
        totalMarks: totalMarks ?? this.totalMarks,
        negativeMarksPerQuestion:
            negativeMarksPerQuestion ?? this.negativeMarksPerQuestion,
        status: status ?? this.status,
        numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
        marksPerQuestion: marksPerQuestion ?? this.marksPerQuestion,
        questionAnswered: questionAnswered ?? this.questionAnswered,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
        totalScore: totalScore ?? this.totalScore,
        durationLeft: durationLeft ?? this.durationLeft,
        userAnswerMap: userAnswerMap ?? this.userAnswerMap,
        originalAnswerMap: originalAnswerMap ?? this.originalAnswerMap,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  factory MockTestModel.fromJson(Map<String, dynamic> json) {
    return MockTestModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        subject: json['subject'] ?? '',
        topic: json['topic'] ?? '',
        description: json['description'] ?? '',
        duration: (json['duration'] ?? 0).toDouble(),
        totalMarks: (json['total_marks'] ?? 0).toDouble(),
        negativeMarksPerQuestion:
            (json['negative_marks_per_question'] ?? 0).toDouble(),
        status: json['status'] ?? 'unknown',
        numberOfQuestions: (json['number_of_questions'] ?? 0).toInt(),
        marksPerQuestion: (json['marks_per_question'] ?? 0).toDouble(),
        questionAnswered: (json['question_attempted'] ?? 0).toInt(),
        correctAnswers: (json['correct_answer'] ?? 0).toInt(),
        incorrectAnswers: (json['incorrect_answer'] ?? 0).toInt(),
        totalScore: (json['total_score'] ?? 0).toDouble(),
        durationLeft: (json['duration_left'] ?? 0).toDouble(),
        userAnswerMap: Map.from(json["user_answer_map"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        originalAnswerMap: Map.from(json["original_answer_map"])
            .map((k, v) => MapEntry<String, String>(k, v)),
        currentQuestionIndex: (json['current_question_index'] ?? 0),
        updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now()));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'topic': topic,
      'description': description,
      'duration': duration,
      'total_marks': totalMarks,
      'negative_marks_per_question': negativeMarksPerQuestion,
      'status': status,
      'number_of_questions': numberOfQuestions,
      'marks_per_question': marksPerQuestion,
      'question_attempted': questionAnswered,
      'correct_answer': correctAnswers,
      'incorrect_answer': incorrectAnswers,
      'total_score': totalScore,
      'duration_left': durationLeft,
      "user_answer_map": Map.from(userAnswerMap)
          .map((k, v) => MapEntry<String, dynamic>(k, v)),
      "original_answer_map": Map.from(originalAnswerMap)
          .map((k, v) => MapEntry<String, dynamic>(k, v)),
      'current_question_index': currentQuestionIndex,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
