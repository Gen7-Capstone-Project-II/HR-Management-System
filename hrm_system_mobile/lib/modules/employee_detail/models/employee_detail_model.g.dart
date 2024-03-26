// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetailModel _$EmployeeDetailModelFromJson(Map<String, dynamic> json) =>
    EmployeeDetailModel(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeeDetailModelToJson(
        EmployeeDetailModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      positionId: json['positionId'] as String?,
      deptId: json['deptId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      firstNameKH: json['firstNameKH'] as String?,
      lastNameKH: json['lastNameKH'] as String?,
      birthDate: json['birthDate'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      personalEmail: json['personalEmail'] as String?,
      phoneNum1: json['phoneNum1'] as String?,
      phoneNume2: json['phoneNume2'] as String?,
      telegram: json['telegram'] as String?,
      attachment: json['attachment'] as String?,
      nationality: json['nationality'] as String?,
      materialStatus: json['materialStatus'] as String?,
      numberOfChild: json['numberOfChild'] as String?,
      employeeDate: json['employeeDate'] as String?,
      status: json['status'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      department: json['department'] == null
          ? null
          : Department.fromJson(json['department'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'positionId': instance.positionId,
      'deptId': instance.deptId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'firstNameKH': instance.firstNameKH,
      'lastNameKH': instance.lastNameKH,
      'birthDate': instance.birthDate,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'personalEmail': instance.personalEmail,
      'phoneNum1': instance.phoneNum1,
      'phoneNume2': instance.phoneNume2,
      'telegram': instance.telegram,
      'attachment': instance.attachment,
      'nationality': instance.nationality,
      'materialStatus': instance.materialStatus,
      'numberOfChild': instance.numberOfChild,
      'employeeDate': instance.employeeDate,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'user': instance.user,
      'position': instance.position,
      'department': instance.department,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      idEmp: json['idEmp'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'idEmp': instance.idEmp,
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      id: json['id'] as String?,
      positionName: json['positionName'] as String?,
      positionDescription: json['positionDescription'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'positionName': instance.positionName,
      'positionDescription': instance.positionDescription,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      id: json['id'] as String?,
      deptName: json['deptName'] as String?,
      deptDescription: json['deptDescription'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deptName': instance.deptName,
      'deptDescription': instance.deptDescription,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
