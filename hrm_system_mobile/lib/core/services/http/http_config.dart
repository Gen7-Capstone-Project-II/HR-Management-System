// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings

import 'http_api_base.dart';

class HttpConfig {
  static Map<String, String> headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Cache-Control': 'no-cache'};

  static const String CLIENT_SECRET = "CLIENT-SECRET";
  static const String CLIENT_BASE_URL = "CLIENT-BASE-URL";
  static const String CLIENT_GATEWAY_CODE = "CLIENT-GATEWAY-CODE";

  HttpApiBase httpApiBase;
  Map<String, dynamic> configPreference = {};

  HttpConfig._(this.httpApiBase) {
    configPreference = httpApiBase.getConfigPreference();
  }

  static HttpConfig? _instance;

  static HttpConfig getInstance() {
    return _instance!;
  }

  static void init(HttpApiBase httpApiBase) {
    _instance = HttpConfig._(httpApiBase);
  }

  String getBaseUrl() {
    String baseUrl = configPreference[CLIENT_BASE_URL];
    return baseUrl;
  }

  String? getBaseApiClientUrl() {
    String? baseUrl = configPreference[CLIENT_BASE_URL];
    if (baseUrl == null || baseUrl == '') {
      return null;
    }
    return "$baseUrl/api";
  }

  String? getBaseClientUrl() {
    String? baseUrl = configPreference[CLIENT_BASE_URL];
    if (baseUrl == null || baseUrl == '') {
      return null;
    }
    return baseUrl;
  }

  String? getApiSecredKey() {
    return configPreference[CLIENT_SECRET] != null ? "Bearer " + configPreference[CLIENT_SECRET] : "";
  }

  String getPrefixCode(String fullText) {
    return configPreference[HttpConfig.CLIENT_GATEWAY_CODE];
  }
}
