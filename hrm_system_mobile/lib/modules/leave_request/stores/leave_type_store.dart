import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/leave_request/models/leave_type_model.dart';
import 'package:human_resource_management_system/modules/leave_request/services/leave_type_service.dart';
import 'package:mobx/mobx.dart';
part 'leave_type_store.g.dart';

class LeaveTypeStore = _LeaveTypeStoreBase with _$LeaveTypeStore;

abstract class _LeaveTypeStoreBase with Store {
  @observable
  LeaveTypeListModel leaveTypeList = LeaveTypeListModel();

  @observable
  LeaveTypeService service = LeaveTypeService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future getLeaveTypeList() async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getLeaveTypeService();
      if (response.statusCode == 200) {
        leaveTypeList = LeaveTypeListModel.fromJson(response.data);
        status = LoadingStatus.done;
      }
    } catch (e) {
      print('${e.runtimeType} : ${e.toString()}');
      status = LoadingStatus.error;
    }
  }

  @action
  void reset() {
    leaveTypeList.data = null;
  }
}
