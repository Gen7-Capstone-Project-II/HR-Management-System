import 'package:json_annotation/json_annotation.dart';

part 'relative_model.g.dart';

@JsonSerializable()
class RelativeTypeListModel {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<RelativeModel>? data;

  RelativeTypeListModel({this.currentPage, this.data});

  factory RelativeTypeListModel.fromJson(Map<String, dynamic> json) =>
      _$RelativeTypeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelativeTypeListModelToJson(this);
}

@JsonSerializable()
class RelativeModel {
  String? id;
  String? relativeName;
  String? description;
  String? createdAt;
  String? updatedAt;

  RelativeModel(
      {this.id,
      this.relativeName,
      this.description,
      this.createdAt,
      this.updatedAt});

  factory RelativeModel.fromJson(Map<String, dynamic> json) =>
      _$RelativeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RelativeModelToJson(this);
}
