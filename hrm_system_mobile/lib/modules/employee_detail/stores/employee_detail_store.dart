import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/employee_detail_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/services/employee_detail_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:mobx/mobx.dart';
part 'employee_detail_store.g.dart';

class EmployeeDetailStore = _EmployeeDetailStoreBase with _$EmployeeDetailStore;

abstract class _EmployeeDetailStoreBase with Store {
  @observable
  EmployeeDetailModel employeeDetails = EmployeeDetailModel();

  @observable
  EmployeeDetailService service = EmployeeDetailService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @observable
  ScanToLoginStore store = ScanToLoginStore();

  @action
  Future getEmployeeDetails(String id) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getEmployeeDetailService(id);
      print(response.data);
      if (response.statusCode == 200) {
        employeeDetails = await compute(
            getEmployeeDetailModel, response.data as Map<String, dynamic>);
        print(employeeDetails);
        status = LoadingStatus.done;
      } 
    } catch (e) {
      print('${e.runtimeType} : ${e.toString()}');
      status = LoadingStatus.error;
    }
  }

  @action
  void reset() {
    employeeDetails.data = null;
  }
}
