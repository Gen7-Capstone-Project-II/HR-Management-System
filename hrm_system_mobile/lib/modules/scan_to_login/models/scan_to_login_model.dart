class ScanToLoginModel {
  String? token;
  String? userId;

  ScanToLoginModel({
    this.token,
    this.userId,
  });

  factory ScanToLoginModel.fromJson(Map<String?, dynamic> json) => ScanToLoginModel(
        token: json['token'],
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user_id": userId,
      };
}