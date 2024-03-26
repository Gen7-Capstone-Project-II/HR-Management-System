import 'package:json_annotation/json_annotation.dart';


part 'attendance_model.g.dart';

AttendanceListModel getAttendanceListModel(Map<String, dynamic> json) {
  return AttendanceListModel.fromJson(json);
}

@JsonSerializable()
class AttendanceListModel {
  List<AttendanceDataListModel>? attendances;

  AttendanceListModel({this.attendances});

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceListModelToJson(this);
}

@JsonSerializable()
class AttendanceDataListModel {
  DateTime? date;
  dynamic attendance;

  AttendanceDataListModel({this.date, this.attendance});

  factory AttendanceDataListModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataListModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataListModelToJson(this);

  bool get isLeave => attendance is String && attendance == 'leave';

  AttendanceDataModel? get attendanceDataList {

    if (attendance == null || attendance is String || attendance == 'leave') {
      return null;
    } else {
      return AttendanceDataModel.fromJson(attendance);
    }
  }
}

@JsonSerializable()
class AttendanceDataModel {
  List<AttendanceModel>? attendanceData;

  AttendanceDataModel({this.attendanceData});

  factory AttendanceDataModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataModelToJson(this);
}

@JsonSerializable()
class AttendanceModel {
  String? id;
  String? empId;
  DateTime? attendanceDate;
  @JsonKey(name: 'time_in')
  DateTime? timeIn;
  @JsonKey(name: 'time_out')
  DateTime? timeOut;
  String? location;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'location_timein')
  String? locationTimeIn;
  @JsonKey(name: 'location_timeout')
  String? locationTimeOut;
  // User? user;

  AttendanceModel({
    this.id,
    this.empId,
    this.attendanceDate,
    this.timeIn,
    this.timeOut,
    this.location,
    this.createdAt,
    this.updatedAt,
    // this.user
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
