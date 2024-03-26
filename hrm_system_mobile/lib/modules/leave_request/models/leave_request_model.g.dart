// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveRequestModelList _$LeaveRequestModelListFromJson(
        Map<String, dynamic> json) =>
    LeaveRequestModelList(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveRequestModelListToJson(
        LeaveRequestModelList instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
    };

LeaveRequestModel _$LeaveRequestModelFromJson(Map<String, dynamic> json) =>
    LeaveRequestModel(
      id: json['id'] as String?,
      empId: json['empId'] as String?,
      leaveTypeId: json['leaveTypeId'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      totalDays: json['totalDays'] as int?,
      reason: json['reason'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      attachment: json['attachment'] as String?,
      isApproved: json['isApproved'] as int?,
      approvedById: json['approvedById'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      employee: json['employee'] == null
          ? null
          : User.fromJson(json['employee'] as Map<String, dynamic>),
      leaveType: json['leave_type'] == null
          ? null
          : LeaveTypeModel.fromJson(json['leave_type'] as Map<String, dynamic>),
      approvedBy: json['approved_by'] == null
          ? null
          : User.fromJson(json['approved_by'] as Map<String, dynamic>),
      isExpanded: json['isExpanded'] as bool? ?? false,
    )..leaveComment = json['leave_comment'] as String?;

Map<String, dynamic> _$LeaveRequestModelToJson(LeaveRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'leaveTypeId': instance.leaveTypeId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'totalDays': instance.totalDays,
      'reason': instance.reason,
      'createdDate': instance.createdDate?.toIso8601String(),
      'attachment': instance.attachment,
      'isApproved': instance.isApproved,
      'approvedById': instance.approvedById,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'employee': instance.employee,
      'leave_comment': instance.leaveComment,
      'leave_type': instance.leaveType,
      'approved_by': instance.approvedBy,
      'isExpanded': instance.isExpanded,
    };
