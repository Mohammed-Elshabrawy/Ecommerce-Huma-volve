import '../../domain/entities/auth_user_entity.dart';

class SignupResModel extends AuthUserEntity {
  final String? password;
  final String? creationAt;
  final String? updatedAt;

  const SignupResModel({
    super.id,
    super.email,
    super.name,
    super.role,
    super.avatar,
    this.password,
    this.creationAt,
    this.updatedAt,
  });

  factory SignupResModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return SignupResModel(
        id: json['id'] ?? 0,
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        role: json['role'] ?? '',
        avatar: json['avatar'] ?? '',
        password: json['password'],
        creationAt: json['creationAt'],
        updatedAt: json['updatedAt'],
      );
    }
    return const SignupResModel();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'avatar': avatar,
      'password': password,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}
