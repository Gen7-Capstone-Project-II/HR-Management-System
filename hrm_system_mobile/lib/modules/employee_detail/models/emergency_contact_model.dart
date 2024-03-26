import 'package:human_resource_management_system/modules/employee_detail/models/relative_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/models/user_model.dart';

part 'emergency_contact_model.g.dart';

@JsonSerializable()
class EmergencyContactModel {
  String? id;
  String? userId;
  String? relativeId;
  String? firstname;
  String? lastname;
  String? firstnameKM;
  String? lastnameKM;
  String? gender;
  String? phoneNum1;
  String? phoneNum2;
  String? telegram;
  String? email;
  String? createdAt;
  String? updatedAt;
  RelativeModel? relative;
  User? user;

  EmergencyContactModel({
    this.id,
    this.userId,
    this.relativeId,
    this.firstname,
    this.lastname,
    this.firstnameKM,
    this.lastnameKM,
    this.gender,
    this.phoneNum1,
    this.phoneNum2,
    this.telegram,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.relative,
    this.user
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactModelFromJson(json);
      

  get phone => null;

  Map<String, dynamic> toJson() => _$EmergencyContactModelToJson(this);
}
