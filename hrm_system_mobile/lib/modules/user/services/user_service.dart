import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class UserServices {
  Future<Response> loginUserServices(String username, String password) async {
    Response response = await ApiService.dio.post(
      'login',
      data: FormData.fromMap(
        {'email': username, 'password': password},
      ),
    );
    return response;
  }
}
