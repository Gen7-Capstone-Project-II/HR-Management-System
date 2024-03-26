import 'package:human_resource_management_system/modules/employee_detail/models/employee_detail_model.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_type_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_request_model.g.dart';

LeaveRequestModelList getLeaveRequestModelList(Map<String, dynamic> json) {
  return LeaveRequestModelList.fromJson(json);
}

@JsonSerializable()
class LeaveRequestModelList {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<LeaveRequestModel>? data;

  LeaveRequestModelList({this.currentPage, this.data});

  factory LeaveRequestModelList.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestModelListFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestModelListToJson(this);
}

@JsonSerializable()
class LeaveRequestModel {
  String? id;
  String? empId;
  String? leaveTypeId;
  DateTime? startDate;
  DateTime? endDate;
  int? totalDays;
  String? reason;
  DateTime? createdDate;
  String? attachment;
  int? isApproved;
  String? approvedById;
  String? createdAt;
  String? updatedAt;
  User? employee;
  @JsonKey(name: 'leave_comment')
  String? leaveComment;
  @JsonKey(name: 'leave_type')
  LeaveTypeModel? leaveType;
  @JsonKey(name: 'approved_by')
  User? approvedBy;
  bool isExpanded;

  LeaveRequestModel({
    this.id,
    this.empId,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.reason,
    this.createdDate,
    this.attachment,
    this.isApproved,
    this.approvedById,
    this.createdAt,
    this.updatedAt,
    this.employee,
    this.leaveType,
    this.approvedBy,
    this.isExpanded = false,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestModelToJson(this);
}
