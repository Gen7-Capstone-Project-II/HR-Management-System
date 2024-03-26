import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? idEmp;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.idEmp, this.name, this.email, this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

UserModel getUserModel(Map<String, dynamic> map) {
  return UserModel.fromJson(map);
}

@JsonSerializable()
class UserModel {
  String? status;
  User? user;
  String? token;
  String? type;

  UserModel({this.status, this.user, this.token, this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
