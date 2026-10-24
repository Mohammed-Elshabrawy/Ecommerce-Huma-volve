class SignupReqModel {
  final String name;
  final String email;
  final String password;

  const SignupReqModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "avatar": "https://api.lorem.space/image/face?w=640&h=480",
      "email": email,
      "name": name,
      "password": password,
    };
  }
}
