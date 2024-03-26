import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class OverTimeService {
  Future<Response> getOverTimeService(String userId) async {
    Response response = await ApiService.dio.get('overtime/$userId');
    return response;
  }

  Future<Response> filterOverTimeService(String userId, dynamic param) async {
    Response response =
        await ApiService.dio.get('overtime/$userId?isApproved=$param');
    return response;
  }

  Future<Response> addOverTimeService({
    required String token,
    required String userId,
    required String date,
    required String startTime,
    required String endTime,
    required String reason,
    required String title,
    required double totalTime,
  }) async {
    print(
        '$totalTime ,$token , $userId , $date , $startTime , $endTime , $reason , $title');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = FormData.fromMap({
      'empId': userId,
      'title': title,
      'reason': reason,
      'dateOT': date,
      'time_from': startTime,
      'time_to': endTime,
      'total_time': totalTime,
    });

    var dio = Dio();
    var response = await dio.request(
      'https://hrm-system-test.up.railway.app/api/overtime',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(json.encode(response.data));
      return response;
    } else {
      print(response.statusMessage);
      return response;
    }
  }
}
