import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class MissionService{
  Future<Response> getMissionService(String userId) async {
    Response response = await ApiService.dio.get('mission/$userId');
    return response;
  }

  Future<Response> filterMissionService(String userId, dynamic param) async{
    Response response = await ApiService.dio.get('mission/$userId?isApproved=$param');
    return response;
  }

  Future<Response> postMissionService({
    required String userId,
    required String typeId,
    required String title,
    required String startDate,
    required String endDate,
     String? budget,
     String? note,
    String? attachment,
    required String token,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = FormData.fromMap({
      'empId': userId,
      'typeId': typeId,
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'budget': budget,
      'note': note,
      'attachment': attachment
    });

    var dio = Dio();
    Response response = await dio.request(
      'https://hrm-system-test.up.railway.app/api/mission',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data);
      return response;
    } else {
      return response;
    }  
  }
}