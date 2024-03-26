import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class LeaveTypeService {
  Future<Response> getLeaveTypeService() async {
    Response response = await ApiService.dio.get('leave_type');
    return response;
  }
}
