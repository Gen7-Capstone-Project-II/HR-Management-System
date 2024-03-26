class LoginModel {
  String? username;
  String? password;
  String? grantType;
  bool? rememberMe = false;
  String? deviceName;
  String? deviceToken;
  String? devicePlatform;

  LoginModel({this.username, this.password, this.grantType, this.rememberMe});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["email"] = username;
    map["password"] = password;
    map["grant_type"] = grantType;
    map["devicename"] = deviceName;
    map["devicetoken"] = deviceToken;
    map["deviceplatform"] = devicePlatform;
    return map;
  }

  @override
  String toString() {
    return "LoginModel = ${toMap().toString()}";
  }
}
