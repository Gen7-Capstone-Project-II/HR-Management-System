import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/attendance/models/current_attendance_model.dart';
import 'package:human_resource_management_system/modules/attendance/services/attendance_service.dart';
import 'package:mobx/mobx.dart';

part 'current_attendance_store.g.dart';

class CurrentAttendanceStore = _CurrentAttendanceStoreBase with _$CurrentAttendanceStore;

abstract class _CurrentAttendanceStoreBase with Store {
  @observable
  CurrentAttendanceModel currentAttendance = CurrentAttendanceModel();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @observable
  AttendanceService service = AttendanceService();

  @action
  Future getCurrentAttendance({required String id, required String month}) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getCurrentAttendanceService(id, month);
      if (response.statusCode == 200) {
        currentAttendance = CurrentAttendanceModel.fromJson(response.data);
        status = LoadingStatus.done;
      }
    } catch (e) {
      status = LoadingStatus.error;
    }
  }
}