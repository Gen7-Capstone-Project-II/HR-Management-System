import 'package:human_resource_management_system/modules/employee_detail/models/employee_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'over_time_model.g.dart';

OverTimeListModel getOverTimeModel(Map<String, dynamic> json) {
  return OverTimeListModel.fromJson(json);
}

@JsonSerializable()
class OverTimeListModel {
  int? currentPage;
  List<OverTimeModel>? data;

  OverTimeListModel({this.currentPage, this.data});

  factory OverTimeListModel.fromJson(Map<String, dynamic> json) =>
      _$OverTimeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverTimeListModelToJson(this);
}

@JsonSerializable()
class OverTimeModel {
  String? id;
  String? empId;
  String? approvedById;
  String? title;
  String? reason;
  String? dateOT;
  @JsonKey(name: 'time_from')
  String? timeFrom;
  @JsonKey(name: 'time_to')
  String? timeTo;
  @JsonKey(name: 'total_time')
  dynamic totalTime;
  dynamic isApproved;
  @JsonKey(name: 'total_approve')
  dynamic totalApprove;
  @JsonKey(name: 'overtime_comment')
  String? overtimeComment;
  String? paid;
  String? createDate;
  String? createdAt;
  String? updatedAt;
  User? employee;
  User? approvedBy;

  OverTimeModel({
    this.id,
    this.empId,
    this.approvedById,
    this.title,
    this.reason,
    this.dateOT,
    this.timeFrom,
    this.timeTo,
    this.totalTime,
    this.isApproved,
    this.totalApprove,
    this.paid,
    this.createDate,
    this.createdAt,
    this.updatedAt,
    this.employee,
    this.approvedBy,
  });

  factory OverTimeModel.fromJson(Map<String, dynamic> json) =>
      _$OverTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverTimeModelToJson(this);
}
