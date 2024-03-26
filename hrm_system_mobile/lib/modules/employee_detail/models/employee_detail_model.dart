import 'package:json_annotation/json_annotation.dart';

part 'employee_detail_model.g.dart';

EmployeeDetailModel getEmployeeDetailModel(Map<String, dynamic> json) {
  return EmployeeDetailModel.fromJson(json);
}

@JsonSerializable()
class EmployeeDetailModel {
  String? message;
  Data? data;

  EmployeeDetailModel({this.message, this.data});

  factory EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    return _$EmployeeDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EmployeeDetailModelToJson(this);
  }
}

@JsonSerializable()
class Data {
  String? id;
  String? userId;
  String? positionId;
  String? deptId;
  String? firstName;
  String? lastName;
  String? firstNameKH;
  String? lastNameKH;
  String? birthDate;
  int? age;
  String? gender;
  String? address;
  String? personalEmail;
  String? phoneNum1;
  String? phoneNume2;
  String? telegram;
  String? attachment;
  String? nationality;
  String? materialStatus;
  String? numberOfChild;
  String? employeeDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  Position? position;
  Department? department;

  Data({
    this.id,
    this.userId,
    this.positionId,
    this.deptId,
    this.firstName,
    this.lastName,
    this.firstNameKH,
    this.lastNameKH,
    this.birthDate,
    this.age,
    this.gender,
    this.address,
    this.personalEmail,
    this.phoneNum1,
    this.phoneNume2,
    this.telegram,
    this.attachment,
    this.nationality,
    this.materialStatus,
    this.numberOfChild,
    this.employeeDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.position,
    this.department,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}

@JsonSerializable()
class User {
  String? id;
  String? idEmp;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.idEmp, this.name, this.email, this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}

@JsonSerializable()
class Position {
  String? id;
  String? positionName;
  String? positionDescription;
  String? createdAt;
  String? updatedAt;

  Position({this.id, this.positionName, this.positionDescription, this.createdAt, this.updatedAt});

  factory Position.fromJson(Map<String, dynamic> json) {
    return _$PositionFromJson(json);
  }

  Map<String, dynamic> json() {
    return _$PositionToJson(this);
  }
}

@JsonSerializable()
class Department {
  String? id;
  String? deptName;
  String? deptDescription;
  String? createdAt;
  String? updatedAt;

  Department({this.id, this.deptName, this.deptDescription, this.createdAt, this.updatedAt});

  factory Department.fromJson(Map<String, dynamic> json) {
    return _$DepartmentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DepartmentToJson(this);
  }
}
