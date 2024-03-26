import 'package:human_resource_management_system/modules/employee_detail/models/emergency_contact_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_emergency_contact_model.g.dart';

@JsonSerializable()
class AllEmergencyContactModel {
  List<EmergencyContactModel>? data;

  AllEmergencyContactModel({this.data});

  factory AllEmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      _$AllEmergencyContactModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllEmergencyContactModelToJson(this);
}
