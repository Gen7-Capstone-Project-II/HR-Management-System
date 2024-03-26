// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionListModel _$MissionListModelFromJson(Map<String, dynamic> json) =>
    MissionListModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissionListModelToJson(MissionListModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
    };

MissionModel _$MissionModelFromJson(Map<String, dynamic> json) => MissionModel(
      id: json['id'] as String?,
      empId: json['empId'] as String?,
      typeId: json['typeId'] as String?,
      title: json['title'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      budget: json['budget'] as String?,
      note: json['note'] as String?,
      attachment: json['attachment'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      isApproved: json['isApproved'] as int?,
      approvedById: json['approvedById'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      missionType: json['mission_type'] == null
          ? null
          : MissionTypeModel.fromJson(
              json['mission_type'] as Map<String, dynamic>),
      approvedBy: json['approved_by'] == null
          ? null
          : User.fromJson(json['approved_by'] as Map<String, dynamic>),
    )..missionComment = json['mission_comment'] as String?;

Map<String, dynamic> _$MissionModelToJson(MissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'typeId': instance.typeId,
      'title': instance.title,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'budget': instance.budget,
      'note': instance.note,
      'attachment': instance.attachment,
      'createdDate': instance.createdDate?.toIso8601String(),
      'isApproved': instance.isApproved,
      'approvedById': instance.approvedById,
      'user': instance.user,
      'mission_comment': instance.missionComment,
      'mission_type': instance.missionType,
      'approved_by': instance.approvedBy,
    };
