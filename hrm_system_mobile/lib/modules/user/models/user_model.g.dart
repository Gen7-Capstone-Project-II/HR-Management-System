// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'status': instance.status,
      'user': instance.user,
      'token': instance.token,
      'type': instance.type,
    };
