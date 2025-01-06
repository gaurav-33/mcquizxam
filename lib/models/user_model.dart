import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstName;
  final String? lastName;
  final String email;
  final String uid;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  UserModel({
    required this.firstName,
    this.lastName,
    required this.email,
    required this.uid,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        uid: json["uid"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"]);
  }

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "uid": uid,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };

  Map<String, dynamic> toSharedPrefJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "uid": uid,
      };

  factory UserModel.fromSharedPrefJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      uid: json["uid"],
    );
  }
}
