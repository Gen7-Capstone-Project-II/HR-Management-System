import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class ScanToLoginService {
  Future<Response> scanToLoginService(Map<String, dynamic> data) async {
    try {
      // Add headers to the request
      Options options = Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      Response response = await ApiService.dio.post(
        'login-token',
        data: data,
        options: options,
      );

      return response;
    } catch (e) {
      throw e;
    }
  }
}
