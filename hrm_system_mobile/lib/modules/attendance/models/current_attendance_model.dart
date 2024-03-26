import 'package:human_resource_management_system/modules/attendance/models/attendance_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_attendance_model.g.dart';

CurrentAttendanceModel getCurrentAttendanceModel(Map<String, dynamic> json) {
  return CurrentAttendanceModel.fromJson(json);
}

@JsonSerializable()
class CurrentAttendanceModel {
  String? message;
  CurrentAttendacneDataModel? data;

  CurrentAttendanceModel({this.message, this.data});

  factory CurrentAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentAttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAttendanceModelToJson(this);
}

@JsonSerializable()
class CurrentAttendacneDataModel {
  DateTime? date;
  List<CurrentModel>? attendance;

  CurrentAttendacneDataModel({this.date, this.attendance});

  factory CurrentAttendacneDataModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentAttendacneDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAttendacneDataModelToJson(this);
}

@JsonSerializable()
class CurrentModel {
  AttendanceModel? attendanceData;

  CurrentModel({this.attendanceData});

  factory CurrentModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentModelToJson(this);
}
