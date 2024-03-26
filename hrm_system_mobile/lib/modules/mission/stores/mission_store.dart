import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/mission/models/mission_model.dart';
import 'package:human_resource_management_system/modules/mission/services/mission_service.dart';
import 'package:mobx/mobx.dart';

part 'mission_store.g.dart';

// ignore: library_private_types_in_public_api
class MissionStore = _MissionStoreBase with _$MissionStore;

abstract class _MissionStoreBase with Store {
  @observable
  MissionListModel missionList = MissionListModel();

  @observable
  MissionService service = MissionService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future getMissionList(String userId) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getMissionService(userId);
      if (response.statusCode == 200) {
        missionList = MissionListModel.fromJson(response.data);
        print('store: ${missionList.data?.map((e) => e.id)}');
        status = LoadingStatus.done;
      }
    } catch (e) {
      status = LoadingStatus.error;
    }
  }

  @action
  Future filterMissionList(
      {required String userId, required dynamic param}) async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.filterMissionService(userId, param);
      if (response.statusCode == 200) {
        print('response ${response.data}');
        print('data ${MissionListModel.fromJson(response.data)}');
        missionList = MissionListModel.fromJson(response.data);
        print('store: ${missionList.data?.map((e) => e.id)}');
        status = LoadingStatus.done;
      }
    } catch (e) {
      print(e);
      status = LoadingStatus.error;
    }
  }
}
