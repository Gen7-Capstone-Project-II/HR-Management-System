// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relative_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelativeTypeListModel _$RelativeTypeListModelFromJson(
        Map<String, dynamic> json) =>
    RelativeTypeListModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RelativeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RelativeTypeListModelToJson(
        RelativeTypeListModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
    };

RelativeModel _$RelativeModelFromJson(Map<String, dynamic> json) =>
    RelativeModel(
      id: json['id'] as String?,
      relativeName: json['relativeName'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$RelativeModelToJson(RelativeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relativeName': instance.relativeName,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
