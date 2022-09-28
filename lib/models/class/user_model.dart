// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.img,
    this.dni,
    this.phone,
    this.profileImg,
    this.skills = const [],
    this.role,
    this.username,
  });

  String? id;
  String? name;
  String? lastName;
  String? email;
  String? password;
  String? validatePassword;
  String? img;
  String? dni;
  String? phone;
  String? profileImg;
  List<dynamic> skills;
  String? role;
  String? username;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        img: json["img"],
        dni: json["dni"],
        phone: json["phone"],
        profileImg: json["profileImg"],
        skills: List<dynamic>.from(json["skills"].map((x) => x)),
        role: json["role"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "password": password,
        // "role": role,
        // "username": username,
        // "skills": List<dynamic>.from(skills.map((x) => x)),
      };
}
