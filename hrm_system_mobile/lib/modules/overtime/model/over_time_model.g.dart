// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'over_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverTimeListModel _$OverTimeListModelFromJson(Map<String, dynamic> json) =>
    OverTimeListModel(
      currentPage: json['currentPage'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OverTimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OverTimeListModelToJson(OverTimeListModel instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'data': instance.data,
    };

OverTimeModel _$OverTimeModelFromJson(Map<String, dynamic> json) =>
    OverTimeModel(
      id: json['id'] as String?,
      empId: json['empId'] as String?,
      approvedById: json['approvedById'] as String?,
      title: json['title'] as String?,
      reason: json['reason'] as String?,
      dateOT: json['dateOT'] as String?,
      timeFrom: json['time_from'] as String?,
      timeTo: json['time_to'] as String?,
      totalTime: json['total_time'],
      isApproved: json['isApproved'],
      totalApprove: json['total_approve'],
      paid: json['paid'] as String?,
      createDate: json['createDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      employee: json['employee'] == null
          ? null
          : User.fromJson(json['employee'] as Map<String, dynamic>),
      approvedBy: json['approvedBy'] == null
          ? null
          : User.fromJson(json['approvedBy'] as Map<String, dynamic>),
    )..overtimeComment = json['overtime_comment'] as String?;

Map<String, dynamic> _$OverTimeModelToJson(OverTimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'approvedById': instance.approvedById,
      'title': instance.title,
      'reason': instance.reason,
      'dateOT': instance.dateOT,
      'time_from': instance.timeFrom,
      'time_to': instance.timeTo,
      'total_time': instance.totalTime,
      'isApproved': instance.isApproved,
      'total_approve': instance.totalApprove,
      'overtime_comment': instance.overtimeComment,
      'paid': instance.paid,
      'createDate': instance.createDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'employee': instance.employee,
      'approvedBy': instance.approvedBy,
    };
