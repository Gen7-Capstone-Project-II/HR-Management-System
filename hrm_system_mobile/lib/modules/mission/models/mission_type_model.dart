import 'package:json_annotation/json_annotation.dart';

part 'mission_type_model.g.dart';

@JsonSerializable()
class MissionTypeListModel {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<MissionTypeModel>? data;

  MissionTypeListModel({this.currentPage, this.data});

  factory MissionTypeListModel.fromJson(Map<String, dynamic> json) =>
      _$MissionTypeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionTypeListModelToJson(this);
}

@JsonSerializable()
class MissionTypeModel {
  String? id;
  @JsonKey(name: 'mission_type')
  String? missionType;
  String? description;

  MissionTypeModel({this.id, this.missionType, this.description});

  factory MissionTypeModel.fromJson(Map<String, dynamic> json) => _$MissionTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MissionTypeModelToJson(this);
}
