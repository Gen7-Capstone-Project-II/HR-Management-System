// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    AnnouncementModel(
      currentPage: json['currentPage'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstPageUrl: json['firstPageUrl'] as String?,
      from: json['from'] as int?,
      lastPage: json['lastPage'] as int?,
      lastPageUrl: json['lastPageUrl'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['nextPageUrl'],
      path: json['path'] as String?,
      perPage: json['perPage'] as int?,
      prevPageUrl: json['prevPageUrl'],
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$AnnouncementModelToJson(AnnouncementModel instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'data': instance.data,
      'firstPageUrl': instance.firstPageUrl,
      'from': instance.from,
      'lastPage': instance.lastPage,
      'lastPageUrl': instance.lastPageUrl,
      'links': instance.links,
      'nextPageUrl': instance.nextPageUrl,
      'path': instance.path,
      'perPage': instance.perPage,
      'prevPageUrl': instance.prevPageUrl,
      'to': instance.to,
      'total': instance.total,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      empId: json['empId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      attachment: json['attachment'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'empId': instance.empId,
      'title': instance.title,
      'description': instance.description,
      'attachment': instance.attachment,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      idEmp: json['idEmp'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'idEmp': instance.idEmp,
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
