import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_request_model.dart';
import 'package:human_resource_management_system/modules/leave_request/services/leave_request_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:mobx/mobx.dart';

part 'leave_request_store.g.dart';

class LeaveRequestStore = _LeaveRequestStoreBase with _$LeaveRequestStore;

abstract class _LeaveRequestStoreBase with Store {
  @observable
  LeaveRequestModelList leaveRequestList = LeaveRequestModelList();

  @observable
  LeaveRequestService service = LeaveRequestService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @observable
  ScanToLoginStore store = ScanToLoginStore();

  @action
  Future getLeaveRequestList(String id) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getLeaveRequestService(id);
      print("userId: $id");
      print("response: ${response.statusCode}");
      print("response: ${response.data}");
      if (response.statusCode == 200) {
        leaveRequestList = LeaveRequestModelList.fromJson(response.data);
        print(leaveRequestList);
        status = LoadingStatus.done;
      }
    } catch (e) {
      print('${e.runtimeType} : ${e.toString()}');
      status = LoadingStatus.error;
    }
  }

  @action
  Future filterLeaveRequestList({required String userId, required dynamic param}) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.filterLeaveRequestService(userId, param);
      print(response.data);
      if (response.statusCode == 200) {
        leaveRequestList = LeaveRequestModelList.fromJson(response.data);
        status = LoadingStatus.done;
      }
    } catch (e) {
      status = LoadingStatus.error;
    }
  }
}
