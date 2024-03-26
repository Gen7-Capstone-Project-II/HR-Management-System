import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/core/services/api_service.dart';
import 'package:human_resource_management_system/modules/scan_to_login/scan_to_login_services/scan_to_login_service.dart';
import 'package:human_resource_management_system/modules/user/models/user_model.dart';
import 'package:human_resource_management_system/core/services/cache_service.dart';

import 'package:mobx/mobx.dart';

part 'scan_to_login_store.g.dart';

// ignore: library_private_types_in_public_api
class ScanToLoginStore = _ScanToLoginStoreBase with _$ScanToLoginStore;

abstract class _ScanToLoginStoreBase with Store {
  @observable
  UserModel? userModel;

  @observable
  LoadingStatus loadingStatus = LoadingStatus.none;

  @observable
  ScanToLoginService scanToLoginService = ScanToLoginService();

  @action
  void setLoadingStatus(LoadingStatus status) {
    loadingStatus = status;
  }

  @action
  Future signIn({required String token, required String userId}) async {
    loadingStatus = LoadingStatus.loading;
    try {
      Response response = await scanToLoginService.scanToLoginService({
        'token': token,
        'user_id': userId,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        userModel = await compute(
          getUserModel,
          response.data as Map<String, dynamic>,
        );
        ApiService.dio..options.headers['Authorization'] = 'Bearer ${userModel!.token}';
        // userModel = UserModel.fromJson(response.data);
        loadingStatus = LoadingStatus.done;
        writeCache(userModel);
      } else {
        loadingStatus = LoadingStatus.error;
        print("Error while login : ${response.statusCode}");
      }
    } catch (e) {
      print('${e.runtimeType} : ${e.toString()}');
      loadingStatus = LoadingStatus.error;
    }
  }

  final CacheService _cacheService = CacheService(key: 'AuthStore');

  Future<void> readCache() async {
    debugPrint('--> START: Reading AuthStore Cache');
    String? value = await _cacheService.readCache();
    if (value != null && value.isNotEmpty) {
      // Check if value is not empty
      try {
        Map<String, dynamic> map = jsonDecode(value);
        userModel = UserModel.fromJson(map);
        ApiService.dio..options.headers['Authorization'] = 'Bearer ${userModel?.token}';
      } catch (e) {
        print('Error decoding JSON data: $e');
      }
      print('user Model token : ${userModel?.token}');
    } else {
      print('Cache is empty or null.');
      // Handle the case when cache is empty, if needed
    }
    debugPrint('--> Value: $value');
    debugPrint('<-- END');
  }

  void writeCache(UserModel? userModel) {
    String? value;
    // if (userModel != null) {
    Map<String, dynamic> map = userModel?.toJson() ?? {};
    try {
      value = jsonEncode(map);
    } catch (e) {
      print('${e.runtimeType}: ${e.toString()}');
    }
    // }
    print("value written to cache: $value");
    _cacheService.writeCache(value);
  }

  @action
  void signOut() {
    userModel = null;
    userModel?.token = '';
    writeCache(userModel);
    print(userModel);
  }
}
