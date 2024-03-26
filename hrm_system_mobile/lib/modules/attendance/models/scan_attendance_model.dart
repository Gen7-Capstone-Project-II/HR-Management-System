class ScanAttendanceModel {
  double? late;
  double? long;

  ScanAttendanceModel({this.late, this.long});

  factory ScanAttendanceModel.fromJson(Map<String, dynamic> json) => ScanAttendanceModel(
        late: json['Latitude'],
        long: json['Longitude'],
      );

  Map<String, dynamic> toJson() => {
        "Latitude": late,
        "Longitude": long,
      };
}
