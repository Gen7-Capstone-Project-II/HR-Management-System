import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class EmployeeDetailService {
  Future<Response> getEmployeeDetailService(String id) async {
    Response response = await ApiService.dio.get('employee_detail/$id', options: Options(
      headers: {
        'Accept': 'application/json',
      },
    ));
    return response;
  }
}
