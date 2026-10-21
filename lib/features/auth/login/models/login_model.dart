class LoginModel {
  LoginModel({this.accessToken, this.refreshToken});

  LoginModel.fromJson(dynamic json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    return map;
  }
}
