// ignore_for_file: constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:human_resource_management_system/core/consts/app_const.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/user/models/auth_token_model.dart';

///
/// [TokenHelper]
///
class TokenHelper {
  SharedPreferences pref;
  PackageInfo packageInfo;

  static const String BASE_URL = "app_base_url";
  static const String ACCESS_TOKEN = "access_token";
  static const String TOKEN_TYPE = "token_type";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EXPIRES_IN = "expires_in";
  static const String EXPIRES_DATE = "expires_date";
  static const String REMEMBER_ME = "remember_me";
  static const String LOADED_INTRO = "loaded_intro";
  static const String TOPIC_SUBCRIPTION = "topic_subcription";
  static const String USER_TOPIC_SUBCRIPTION = "user_topic_subcription"; // individual user
  static const String USER_KEY = "user_key";
  static const String SELECTED_DEFAULT_LANGUAGE = "selected_default_language";
  static const String LANGUAGE = "language";
  static const String LOGIN_KEY = "login_key";

  TokenHelper._(this.pref, this.packageInfo);

  static TokenHelper? _instance;
  static TokenHelper getInstance() {
    return _instance!;
  }

  static void init(SharedPreferences pref, packageInfo) {
    _instance = TokenHelper._(pref, packageInfo);
  }

  bool isAuth() {
    return getAccessToken() != null;
  }

  void saveToken(AuthTokenModel token) async {
    await pref.setString(ACCESS_TOKEN, token.accessToken ??= '');
    await pref.setString(TOKEN_TYPE, token.tokenType ??= '');
    await pref.setString(REFRESH_TOKEN, token.refreshToken ??= '');
    await pref.setInt(EXPIRES_IN, token.expiresIn ??= 0);

    // DateTime expireDate = DateHelper.getDatePlusSecond(DateTime.now(), token.expiresIn);
    // String formateDate = DateHelper.format(expireDate, DateHelper.timeFormatddMMyyyHHMMA);
    // await pref.setString(EXPIRES_DATE, formateDate);
  }

  Future<bool> clear() async {
    await pref.remove(BASE_URL);
    await pref.remove(ACCESS_TOKEN);
    await pref.remove(TOKEN_TYPE);
    await pref.remove(REFRESH_TOKEN);
    await pref.remove(EXPIRES_IN);
    await pref.remove(EXPIRES_DATE);
    await pref.remove(REMEMBER_ME);
    await pref.remove(USER_KEY);
    return true;
  }

  String? getKey(String key) {
    String? value = pref.getString(key);
    print("TokenHelper[$key]:${value ??= ''}");
    return value;
  }

  void addKey(String key, String value) async {
    await pref.setString(key, value);
  }

  void removeKey(String key) async {
    await pref.remove(key);
    debugPrint("$key has been removed!");
  }

  bool getBooleanKey(String key) {
    bool value = pref.getBool(key) ?? false;
    print("TokenHelper[" + key + "]:" + '$value');
    return value;
  }

  void addBooleanKey(String key, bool value) async {
    await pref.setBool(key, value);
  }

  String? getBaseUrl() {
    String? value = pref.getString(BASE_URL);
    return value;
  }

  void setBaseURl(String url) async {
    await pref.setString(BASE_URL, url);
  }

  String? getAccessToken() {
    String? value = pref.getString(ACCESS_TOKEN);
    return value;
  }

  String? getRefreshToken() {
    String? value = pref.getString(REFRESH_TOKEN);
    return value;
  }

  void setAccessToken(String data) async {
    await pref.setString(ACCESS_TOKEN, data);
  }

  void setRefreshToken(String data) async {
    await pref.setString(REFRESH_TOKEN, data);
  }

  bool getRememberMe() {
    bool value = pref.getBool(REMEMBER_ME) ?? false;
    print("TokenHelper[$REMEMBER_ME]:${value ? 'true' : 'false'}");
    return value;
  }

  void setRememberMe(bool? rememberMe) async {
    await pref.setBool(REMEMBER_ME, rememberMe ?? false);
  }

  bool getLoadedIntro() {
    if (!AppConst.APP_ENABLE_INTRO) {
      return true;
    }
    bool value = pref.getBool(LOADED_INTRO) ?? false;
    print("TokenHelper[$LOADED_INTRO]:${value ? 'true' : 'false'}");
    return value;
  }

  void setLoadedIntro(bool? loadedIntro) async {
    await pref.setBool(LOADED_INTRO, loadedIntro ?? false);
  }

  String? getTopicSubscription() {
    String? value = pref.getString(TOPIC_SUBCRIPTION);
    print("TokenHelper[$TOPIC_SUBCRIPTION]:${value ??= ''}");
    return value;
  }

  void setTopicSubscription(String topic) async {
    await pref.setString(TOPIC_SUBCRIPTION, topic);
  }

  void setUserTopicSubscription(String topic) async {
    await pref.setString(USER_TOPIC_SUBCRIPTION, topic);
  }

  bool isTokenExpire() {
    String? expireDateStr = pref.getString(EXPIRES_DATE);
    if (expireDateStr == null || expireDateStr == '') {
      return true;
    }
    return false;
    // DateTime expireDate = DateHelper.getDate(expireDateStr, DateHelper.timeFormatddMMyyyHHMMA);
    // DateTime currentDate = DateTime.now();

    // if (AppConst.APP_PRODUCTION_MODE) {
    //   int nbDate = expireDate.difference(currentDate).inDays;
    //   print("Token Expire in $nbDate days.");
    //   return nbDate <= 1;
    // } else {
    //   int inMinutes = expireDate.difference(currentDate).inMinutes;
    //   print("Token Expire in $inMinutes minutes.");
    //   return inMinutes <= 2;
    // }
  }

  String getAppVersion() {
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return "${AppConst.APP_PRODUCTION_MODE ? "V." : "DEV."}$version Build $buildNumber";
  }

  bool getSelectedDefaultLanguage() {
    if (!AppConst.APP_ENABLE_INTRO) {
      return true;
    }
    bool value = pref.getBool(SELECTED_DEFAULT_LANGUAGE) ?? false;
    print("TokenHelper[$SELECTED_DEFAULT_LANGUAGE]:${value ? 'true' : 'false'}");
    return value;
  }
}
