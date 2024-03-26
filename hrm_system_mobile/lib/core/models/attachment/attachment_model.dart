import 'dart:convert';

import 'package:human_resource_management_system/core/services/http/http_config.dart';

class AttachmentModel {
  int? id;
  int? size;
  String? refId;
  String? fileName;
  String? path;
  String? url;

  AttachmentModel({
    this.id,
    this.size,
    this.refId,
    this.fileName,
    this.path,
    this.url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => AttachmentModel(
        id: json["id"],
        refId: json["ref_id"],
        size: json["size"],
        fileName: json["file_name"] ??= "",
        path: json["path"] == null ? "" : HttpConfig.getInstance().getBaseUrl() + json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref_id": refId,
        "size": size,
        "file_name": fileName,
        "path": path,
        "url": url,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
