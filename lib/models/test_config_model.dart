class TestConfigModel {
  TestConfigModel({
    required this.questionCounts,
    required this.marksPerQuestion,
    required this.negativeMarks,
    required this.durations,
  });

  final List<int> questionCounts;
  final List<double> marksPerQuestion;
  final List<double> negativeMarks;
  final List<double> durations;

  factory TestConfigModel.fromJson(Map<String, dynamic> json) {
    return TestConfigModel(
      questionCounts: json["question_counts"] == null
          ? []
          : List<int>.from(json["question_counts"]!.map((x) => x)),
      marksPerQuestion: json["marks_per_question"] == null
          ? []
          : List<double>.from(
              json["marks_per_question"]!.map((x) => (x as num).toDouble())),
      negativeMarks: json["negative_marks"] == null
          ? []
          : List<double>.from(
              json["negative_marks"]!.map((x) => (x as num).toDouble())),
      durations: json["durations"] == null
          ? []
          : List<double>.from(
              json["durations"]!.map((x) => (x as num).toDouble())),
    );
  }

  Map<String, dynamic> toJson() => {
        "question_counts": questionCounts.map((x) => x).toList(),
        "marks_per_question": marksPerQuestion.map((x) => x).toList(),
        "negative_marks": negativeMarks.map((x) => x).toList(),
        "durations": durations.map((x) => x).toList(),
      };
}
