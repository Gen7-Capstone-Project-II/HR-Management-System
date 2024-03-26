import 'package:dio/dio.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/mission/models/mission_type_model.dart';
import 'package:human_resource_management_system/modules/mission/services/mission_type_service.dart';
import 'package:mobx/mobx.dart';

part 'mission_type_store.g.dart';

// ignore: library_private_types_in_public_api
class MissionTypeStore = _MissionTypeStoreBase with _$MissionTypeStore;

abstract class _MissionTypeStoreBase with Store {
  @observable
  MissionTypeListModel missionTypeList = MissionTypeListModel();

  @observable
  MissionTypeService service = MissionTypeService();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future getMissionTypeListStore() async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getMissionTypeService();
      if (response.statusCode == 200) {
        missionTypeList = MissionTypeListModel.fromJson(response.data);
        status = LoadingStatus.done;
      } else {
        status = LoadingStatus.error;
      }
    } catch (e) {
      print('${e.runtimeType} : ${e.toString()}');
      status = LoadingStatus.error;
    }
  }
}
