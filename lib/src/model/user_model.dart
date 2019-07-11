// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModeltToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String career;
    String email;
    String imagen;
    String name;

    UserModel({
        this.career,
        this.email,
        this.imagen,
        this.name,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        career: json["career"],
        email: json["email"],
        imagen: json["imagen"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "career": career,
        "email": email,
        "imagen": imagen,
        "name": name,
    };
}
