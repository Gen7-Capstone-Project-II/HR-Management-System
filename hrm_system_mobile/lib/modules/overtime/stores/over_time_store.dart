import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/overtime/model/over_time_model.dart';
import 'package:human_resource_management_system/modules/overtime/services/over_time_service.dart';
import 'package:mobx/mobx.dart';

part 'over_time_store.g.dart';

class OverTimeStore = _OverTimeStoreBase with _$OverTimeStore;

abstract class _OverTimeStoreBase with Store {
  @observable
  OverTimeListModel overTimeList = OverTimeListModel();

  @observable
  OverTimeListModel pendingOverTime = OverTimeListModel();

  @observable
  OverTimeListModel approvedOverTime = OverTimeListModel();

  @observable
  OverTimeListModel rejectedOverTime = OverTimeListModel();

  @observable
  OverTimeService service = OverTimeService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future getOverTimeList(String id) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getOverTimeService(id);
      if (response.statusCode == 200) {
        print(response.data);
        overTimeList = OverTimeListModel.fromJson(response.data);
        print(overTimeList.data?.length);
        status = LoadingStatus.done;
      }
    } catch (e) {
      status = LoadingStatus.error;
    }
  }

  @action
  Future filterOverTimeList(
      {required String userId, required dynamic param}) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.filterOverTimeService(userId, param);
      print(response.data);
      if (response.statusCode == 200) {
        overTimeList = await compute(
            getOverTimeModel, response.data as Map<String, dynamic>);
        status = LoadingStatus.done;
      }
    } catch (e) {
      print(e.toString());
      status = LoadingStatus.error;
    }
  }
}
