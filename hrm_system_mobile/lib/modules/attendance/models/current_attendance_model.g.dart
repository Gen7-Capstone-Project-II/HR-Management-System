// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAttendanceModel _$CurrentAttendanceModelFromJson(
        Map<String, dynamic> json) =>
    CurrentAttendanceModel(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CurrentAttendacneDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentAttendanceModelToJson(
        CurrentAttendanceModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

CurrentAttendacneDataModel _$CurrentAttendacneDataModelFromJson(
        Map<String, dynamic> json) =>
    CurrentAttendacneDataModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => CurrentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentAttendacneDataModelToJson(
        CurrentAttendacneDataModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'attendance': instance.attendance,
    };

CurrentModel _$CurrentModelFromJson(Map<String, dynamic> json) => CurrentModel(
      attendanceData: json['attendanceData'] == null
          ? null
          : AttendanceModel.fromJson(
              json['attendanceData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentModelToJson(CurrentModel instance) =>
    <String, dynamic>{
      'attendanceData': instance.attendanceData,
    };
