class AuthTokenModel {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;

  AuthTokenModel({this.accessToken, this.tokenType, this.refreshToken, this.expiresIn});

  AuthTokenModel.fromMap(dynamic object) {
    accessToken = object["access_token"];
    tokenType = object["token_type"];
    refreshToken = object["refresh_token"];
    expiresIn = object["expires_in"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["access_token"] = accessToken;
    map["token_type"] = tokenType;
    map["refresh_token"] = refreshToken;
    map["expires_in"] = expiresIn;
    return map;
  }

  @override
  String toString() {
    return "TokenMdelResponse = ${toMap().toString()}";
  }
}

class AuthResult {
  bool? success = false;
  String? redirectPath;

  AuthResult({this.success, this.redirectPath});
}
