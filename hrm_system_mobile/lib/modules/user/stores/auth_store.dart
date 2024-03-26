import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';
import 'package:human_resource_management_system/core/services/cache_service.dart';
import 'package:human_resource_management_system/modules/user/models/user_model.dart';
import 'package:human_resource_management_system/modules/user/services/user_service.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UserModel? userModel;

  @observable
  LoadingStatus loadingStatus = LoadingStatus.none;

  @observable
  UserServices userServices = UserServices();

  @action
  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
  }

  @action
  Future signIn(String username, String password) async {
    loadingStatus = LoadingStatus.loading;
    try {
      Response response = await userServices.loginUserServices(username, password);
      if (response.statusCode == 200) {
        userModel = await compute(
          getUserModel,
          response.data as Map<String, dynamic>,
        );
        ApiService.dio..options.headers['Authorization'] = 'Bearer ${userModel!.token}';
        loadingStatus = LoadingStatus.done;
        writeCache();
      } else {
        loadingStatus = LoadingStatus.error;
        print("Error while login : ${response.statusCode}");
      }
    } catch (e) {
      loadingStatus = LoadingStatus.error;
      print('${e.runtimeType}: ${e.toString()}');
    }
  }

  CacheService _cacheService = CacheService(key: 'AuthStore');

  Future readCache() async {
    debugPrint('--> START: Reading AuthStore Cache');
    String? value = await _cacheService.readCache();
    if (value != null) {
      Map<String, dynamic> map = jsonDecode(value);
      userModel = UserModel.fromJson(map);

      ApiService.dio..options.headers['Authorization'] = 'Bearer ${userModel!.token}';
    }
    debugPrint('--> Value: $value');
    debugPrint('<-- END');
  }

  void writeCache() {
    String? value;
    if (userModel != null) {
      Map<String, dynamic> map = userModel?.toJson() ?? {};
      try {
        value = jsonEncode(map);
      } catch (e) {
        print('${e.runtimeType}: ${e.toString()}');
      }
    }
    print("value written to cache: $value");
    _cacheService.writeCache(value);
  }

  @action
  void signOut() {
    userModel = null;
    writeCache();
  }
}
