import 'dart:convert';

import 'package:human_resource_management_system/core/helpers/common_helper.dart';

HttpCustomReponse httpCustomReponseFromJson(String str) => HttpCustomReponse.fromJson(json.decode(str));
String httpCustomReponseToJson(HttpCustomReponse data) => json.encode(data.toJson());

class HttpCustomReponse {
  int? statusCode;
  dynamic data;
  String? message;
  String? messageI18n;

  HttpCustomReponse({
    this.statusCode,
    this.data,
    this.message,
    this.messageI18n,
  });

  factory HttpCustomReponse.fromJson(Map<String, dynamic> json) => HttpCustomReponse(
        statusCode: json["statusCode"],
        data: json["data"],
        message: json["message"] ??= "",
        messageI18n: json["messageEn"] ??= "",
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data,
        "message": message,
        "messageEn": messageI18n,
      };

  Map<String, dynamic>? getDataMap() {
    return CommonHelper.tryCast<Map<String, dynamic>>(data, defaultFallback: null);
  }

  List? getDataList() {
    return CommonHelper.tryCast<List>(data, defaultFallback: []);
  }
}
