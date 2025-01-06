class SubjectModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  SubjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image_url": imageUrl,
    };
  }
}

class TopicModel {
  final String id;
  final String subjectId;
  final String name;
  final String description;
  final String imageUrl;
  final String? status;

  TopicModel({
    required this.id,
    required this.subjectId,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.status,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json["id"],
      subjectId: json["subject_id"],
      name: json["name"],
      description: json["description"],
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subject_id": subjectId,
      "name": name,
      "description": description,
      "image_url": imageUrl,
    };
  }
}
