// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeListModel _$LeaveTypeListModelFromJson(Map<String, dynamic> json) =>
    LeaveTypeListModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveTypeListModelToJson(LeaveTypeListModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
    };

LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) =>
    LeaveTypeModel(
      id: json['id'] as String?,
      leaveType: json['leaveType'] as String?,
      defaultDays: json['defaultDays'] as int?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$LeaveTypeModelToJson(LeaveTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leaveType': instance.leaveType,
      'defaultDays': instance.defaultDays,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
