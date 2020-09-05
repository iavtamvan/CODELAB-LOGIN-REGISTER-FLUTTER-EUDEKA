import 'dart:convert';

class LoginModel {
  int id;
  String token;
  String error;

  LoginModel({this.id, this.token, this.error});

  factory LoginModel.fromJson(String str) => LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    id: json["id"],
    token: json["token"],
    error: json["error"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "token": token,
    "error": error,
  };

}