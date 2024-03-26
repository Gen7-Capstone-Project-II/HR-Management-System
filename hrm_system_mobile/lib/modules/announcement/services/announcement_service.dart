import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class AnnouncementService {
  Future<Response> getAnnouncementService() async {
    Response response = await ApiService.dio.get('announcement');

    return response;
  }
}
