// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_emergency_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllEmergencyContactModel _$AllEmergencyContactModelFromJson(
        Map<String, dynamic> json) =>
    AllEmergencyContactModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => EmergencyContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllEmergencyContactModelToJson(
        AllEmergencyContactModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
