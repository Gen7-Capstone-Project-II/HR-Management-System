import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/attendance/models/attendance_model.dart';
import 'package:human_resource_management_system/modules/attendance/services/attendance_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:mobx/mobx.dart';

part 'attendance_store.g.dart';

class AttendanceStore = _AttendanceStoreBase with _$AttendanceStore;

abstract class _AttendanceStoreBase with Store {
  @observable
  AttendanceListModel attendanceList = AttendanceListModel();

  @observable
  AttendanceService service = AttendanceService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @observable
  ScanToLoginStore scanToLoginStore = ScanToLoginStore();

  @action
  Future getAttendanceList(String id, String month) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getAttendanceService(id, month);
      if (response.statusCode == 200) {
        attendanceList = AttendanceListModel.fromJson(response.data['data']);
        // print('attendanceList: ${attendanceList.attendances?.first.attendanceDataList!.first.attendanceData?.timeIn}');
        status = LoadingStatus.done;
      }
    } catch (e) {
      print('catch error');
      print(e);
      status = LoadingStatus.error;
    }
  }

  @action
  void reset() {
    attendanceList.attendances = null;
  }
}
