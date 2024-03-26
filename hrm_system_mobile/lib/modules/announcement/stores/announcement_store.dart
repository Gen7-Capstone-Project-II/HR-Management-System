import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/announcement/models/announcement_model.dart';
import 'package:human_resource_management_system/modules/announcement/services/announcement_service.dart';
import 'package:mobx/mobx.dart';
part 'announcement_store.g.dart';

class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  @observable
  AnnouncementModel announcementModel = AnnouncementModel();

  @observable
  LoadingStatus status = LoadingStatus.none;

  @observable
  AnnouncementService service = AnnouncementService();

  @action
  Future getAnnouncement() async {
    try {
      status = LoadingStatus.loading;
      Response response = await service.getAnnouncementService();
      if (response.statusCode == 200) {
        print(response.data);
        announcementModel = await compute(getAnnouncementModel, response.data as Map<String, dynamic>);
        status = LoadingStatus.done;
      }
    } catch (e) {
      print('${e.runtimeType}: ${e.toString()}');
      status = LoadingStatus.error;
    }
  }

  @action
  void reset() {
    announcementModel.data = null;
  }
}
