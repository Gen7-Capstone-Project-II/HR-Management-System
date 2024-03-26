import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class LeaveRequestService {
  Future<Response> getLeaveRequestService(String userId) async {
    Response response = await ApiService.dio.get('leave/$userId');
    return response;
  }

  Future<Response> filterLeaveRequestService(String userId, dynamic param) async{
    Response response = await ApiService.dio.get('leave/$userId?isApproved=$param');
    return response;
  }

  Future<Response> addLeaveRequestService({
    required String userId,
    required String leaveType,
    required String startDate,
    required String endDate,
    required String reason,
    String? attachment,
    required String token,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = FormData.fromMap({
      'empId': userId,
      'leaveTypeId': leaveType,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason
    });

    var dio = Dio();
    Response response = await dio.request(
      'https://hrm-system-test.up.railway.app/api/leave',
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
