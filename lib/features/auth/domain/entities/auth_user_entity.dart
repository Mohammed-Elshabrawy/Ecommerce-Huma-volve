class AuthUserEntity {
  final int id;
  final String email;
  final String name;
  final String role;
  final String avatar;

  const AuthUserEntity({
    this.id = 0,
    this.email = '',
    this.name = '',
    this.role = '',
    this.avatar = '',
  });
}
