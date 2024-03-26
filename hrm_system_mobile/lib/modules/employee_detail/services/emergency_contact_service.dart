import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';

class EmergencyContactService {
  Future<Response> getEmergencyContactService(String userId) async {
    Response response = await ApiService.dio.get('emergencycontact/$userId');
    return response;
  }

  Future<Response> updateEmergencyContactService(
      {required String emergencyId,
      required String userId,
      required String relativeId,
      required String firstName,
      required String lastName,
      required String gender,
      required String phoneNum1}) async {
    Response response =
        await ApiService.dio.put('emergencycontact/$emergencyId',
            data: {
              'user_id': userId,
              'relative_id': relativeId,
              'firstname': firstName,
              'lastname': lastName,
              'gender': gender,
              'phoneNum1': phoneNum1,
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

  Future<Response> addEmergencyContactService(
      {required String userId,
      required String relativeId,
      required String firstName,
      required String lastName,
      required String gender,
      required String phoneNum1}) async {
    print('user_id $userId');
    print('relativeId $relativeId');
    print('first name $firstName');
    print('Last name $lastName');
    print('gender $gender');
    print('phonNumber $phoneNum1');
    Response response = await ApiService.dio.post('emergencycontact',
        data: {
          'user_id': userId,
          'relative_id': relativeId,
          'firstname': firstName,
          'lastname': lastName,
          'gender': gender,
          'phoneNum1': phoneNum1,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ));
    print("++++++++++++++response from updateTimeIn++++++++++++++");
    print(response.statusCode);
    print(response.data);
    return response;
  }

  Future<Response> deleteEmergencyContactService(String emergencyId) async {
    Response response = await ApiService.dio.delete(
      'emergencycontact/$emergencyId',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return response;
  }

  Future<Response> getRelativeService() async {
    Response response = await ApiService.dio.get('relative',
        options: Options(headers: {
          'Accept': 'application/json',
        }));

    return response;
  }
}
