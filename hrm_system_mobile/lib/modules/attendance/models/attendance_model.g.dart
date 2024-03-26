// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceListModel _$AttendanceListModelFromJson(Map<String, dynamic> json) =>
    AttendanceListModel(
      attendances: (json['attendances'] as List<dynamic>?)
          ?.map((e) =>
              AttendanceDataListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttendanceListModelToJson(
        AttendanceListModel instance) =>
    <String, dynamic>{
      'attendances': instance.attendances,
    };

AttendanceDataListModel _$AttendanceDataListModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceDataListModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      attendance: json['attendance'],
    );

Map<String, dynamic> _$AttendanceDataListModelToJson(
        AttendanceDataListModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'attendance': instance.attendance,
    };

AttendanceDataModel _$AttendanceDataModelFromJson(Map<String, dynamic> json) =>
    AttendanceDataModel(
      attendanceData: (json['attendanceData'] as List<dynamic>?)
          ?.map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttendanceDataModelToJson(
        AttendanceDataModel instance) =>
    <String, dynamic>{
      'attendanceData': instance.attendanceData,
    };

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      id: json['id'] as String?,
      empId: json['empId'] as String?,
      attendanceDate: json['attendanceDate'] == null
          ? null
          : DateTime.parse(json['attendanceDate'] as String),
      timeIn: json['time_in'] == null
          ? null
          : DateTime.parse(json['time_in'] as String),
      timeOut: json['time_out'] == null
          ? null
          : DateTime.parse(json['time_out'] as String),
      location: json['location'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    )
      ..locationTimeIn = json['location_timein'] as String?
      ..locationTimeOut = json['location_timeout'] as String?;

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'attendanceDate': instance.attendanceDate?.toIso8601String(),
      'time_in': instance.timeIn?.toIso8601String(),
      'time_out': instance.timeOut?.toIso8601String(),
      'location': instance.location,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'location_timein': instance.locationTimeIn,
      'location_timeout': instance.locationTimeOut,
    };
