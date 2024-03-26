import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class AttendanceService {
  Future<Response> getAttendanceService(String userId, String month) async {
    Response response = await ApiService.dio
        .get('employee/attendances?empId=$userId&month=$month');
    return response;
  }

  Future<Response> postAttendanceService(String userId, String location) async {
    Response response = await ApiService.dio.post('attendances', data: {
      'empId': userId,
      'location': location,
    });

    return response;
  }

  Future<Response> getCurrentAttendanceService(
      String userId, String month) async {
    Response response = await ApiService.dio
        .get('employee/attendance?empId=$userId&month=$month',
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ));
    print(response.data);
    return response;
  }

  Future<Response> updateTimeIn(
      {required String attendanceId,
      required String timeIn,
      required String locationTimeIn,
      required String token}) async {
    print('timeIn: $timeIn');
    print('location $locationTimeIn');
    Response response =
        await ApiService.dio.put('attendances/$attendanceId/time-in',
            data: {
              'time_in': timeIn,
              'location_timein': locationTimeIn,
            },
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ));
    print("++++++++++++++response from updateTimeIn++++++++++++++");
    print(response.statusCode);
    print(response.data);

    return response;
  }

  Future<Response> updateTimeOut(
      {required String attendanceId,
      required String timeOut,
      required String locationTimeOut}) async {
    Response response =
        await ApiService.dio.put('attendances/$attendanceId/time-out',
            data: {'time_out': timeOut, 'location_timeout': locationTimeOut},
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ));
    return response;
  }
}
