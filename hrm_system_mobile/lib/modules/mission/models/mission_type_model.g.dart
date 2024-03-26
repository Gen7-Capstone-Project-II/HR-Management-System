// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionTypeListModel _$MissionTypeListModelFromJson(
        Map<String, dynamic> json) =>
    MissionTypeListModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MissionTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissionTypeListModelToJson(
        MissionTypeListModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
    };

MissionTypeModel _$MissionTypeModelFromJson(Map<String, dynamic> json) =>
    MissionTypeModel(
      id: json['id'] as String?,
      missionType: json['mission_type'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MissionTypeModelToJson(MissionTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mission_type': instance.missionType,
      'description': instance.description,
    };
