import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/all_emergency_contact_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/models/relative_model.dart';
import 'package:human_resource_management_system/modules/employee_detail/services/emergency_contact_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/stores/scan_to_login_store.dart';
import 'package:mobx/mobx.dart';

part 'emergency_contact_store.g.dart';

// ignore: library_private_types_in_public_api
class EmergencyContactStore = _EmergencyContactStoreBase
    with _$EmergencyContactStore;

abstract class _EmergencyContactStoreBase with Store {
  @observable
  AllEmergencyContactModel emergencyContacts = AllEmergencyContactModel();

  @observable
  EmergencyContactService services = EmergencyContactService();

  @observable
  RelativeTypeListModel relativeTypeListModel = RelativeTypeListModel();

  @observable
  LoadingStatus state = LoadingStatus.none;

  @observable
  ScanToLoginStore store = ScanToLoginStore();

  @action
  Future getEmergencyContact(String userId) async {
    try {
      state = LoadingStatus.loading;
      var response = await services.getEmergencyContactService(userId);
      if (response.statusCode == 200) {
        emergencyContacts = AllEmergencyContactModel.fromJson(response.data);

        state = LoadingStatus.done;
      }
    } catch (e) {
      state = LoadingStatus.error;
    }
  }

  @action
  Future getRelativeTypeList() async {
    try {
      state = LoadingStatus.loading;
      var response = await services.getRelativeService();
      print('relative type ${response.data}');
      if (response.statusCode == 200) {
        relativeTypeListModel = RelativeTypeListModel.fromJson(response.data);
        state = LoadingStatus.done;
      }
    } catch (e) {
      state = LoadingStatus.error;
    }
  }

  @action
  void reset() {
    emergencyContacts.data = null;
  }
}
