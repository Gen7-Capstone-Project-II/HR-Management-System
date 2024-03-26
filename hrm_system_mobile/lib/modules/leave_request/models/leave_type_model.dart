import 'package:json_annotation/json_annotation.dart';

part 'leave_type_model.g.dart';

@JsonSerializable()
class LeaveTypeListModel {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<LeaveTypeModel>? data;

  LeaveTypeListModel({this.currentPage, this.data});

  factory LeaveTypeListModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeListModelToJson(this);

}

@JsonSerializable()
class LeaveTypeModel {
  String? id;
  String? leaveType;
  int? defaultDays;
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  LeaveTypeModel(
      {this.id,
      this.leaveType,
      this.defaultDays,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeModelToJson(this);
}
