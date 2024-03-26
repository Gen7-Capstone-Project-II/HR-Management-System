import 'package:human_resource_management_system/modules/employee_detail/models/employee_detail_model.dart';
import 'package:human_resource_management_system/modules/mission/models/mission_type_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mission_model.g.dart';

MissionListModel getMissionListModel(Map<String, dynamic> json) {
  return MissionListModel.fromJson(json);
}

@JsonSerializable()
class MissionListModel {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<MissionModel>? data;

  MissionListModel({this.currentPage, this.data});

  factory MissionListModel.fromJson(Map<String, dynamic> json) =>
      _$MissionListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionListModelToJson(this);
}

@JsonSerializable()
class MissionModel {
  String? id;
  String? empId;
  String? typeId;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  String? budget;
  String? note;
  String? attachment;
  DateTime? createdDate;
  int? isApproved;
  String? approvedById;
  User? user;
  @JsonKey(name: 'mission_comment')
  String? missionComment;
  @JsonKey(name: 'mission_type')
  MissionTypeModel? missionType;
  @JsonKey(name: 'approved_by')
  User? approvedBy;
  MissionModel(
      {this.id,
      this.empId,
      this.typeId,
      this.title,
      this.startDate,
      this.endDate,
      this.budget,
      this.note,
      this.attachment,
      this.createdDate,
      this.isApproved,
      this.approvedById,
      this.user,
      this.missionType,
      this.approvedBy});

  factory MissionModel.fromJson(Map<String, dynamic> json) =>
      _$MissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionModelToJson(this);
}
