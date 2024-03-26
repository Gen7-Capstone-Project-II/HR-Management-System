import 'package:json_annotation/json_annotation.dart';

part 'announcement_model.g.dart';

AnnouncementModel getAnnouncementModel(Map<String, dynamic> json) {
  return AnnouncementModel.fromJson(json);
}

@JsonSerializable()
class AnnouncementModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  AnnouncementModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) => _$AnnouncementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementModelToJson(this);
}

@JsonSerializable()
class Data {
  String? id;
  String? empId;
  String? title;
  String? description;
  String? attachment;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;
  User? user;

  Data({this.id, this.empId, this.title, this.description, this.attachment, this.createdAt, this.updatedAt, this.user});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  String? id;
  String? idEmp;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.idEmp,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
