// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContactModel _$EmergencyContactModelFromJson(
        Map<String, dynamic> json) =>
    EmergencyContactModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      relativeId: json['relativeId'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      firstnameKM: json['firstnameKM'] as String?,
      lastnameKM: json['lastnameKM'] as String?,
      gender: json['gender'] as String?,
      phoneNum1: json['phoneNum1'] as String?,
      phoneNum2: json['phoneNum2'] as String?,
      telegram: json['telegram'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      relative: json['relative'] == null
          ? null
          : RelativeModel.fromJson(json['relative'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmergencyContactModelToJson(
        EmergencyContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'relativeId': instance.relativeId,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'firstnameKM': instance.firstnameKM,
      'lastnameKM': instance.lastnameKM,
      'gender': instance.gender,
      'phoneNum1': instance.phoneNum1,
      'phoneNum2': instance.phoneNum2,
      'telegram': instance.telegram,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'relative': instance.relative,
      'user': instance.user,
    };
