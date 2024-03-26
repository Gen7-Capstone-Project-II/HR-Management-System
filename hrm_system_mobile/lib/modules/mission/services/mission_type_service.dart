import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class MissionTypeService {
  Future<Response> getMissionTypeService() async {
    Response response = await ApiService.dio.get('mission_type');
    return response;
  }
}