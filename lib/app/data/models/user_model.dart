class User {
  int id;
  String avatar;
  String name;
  String email;
  String emailVerifiedAt;

  User({
    id,
    avatar,
    name,
    email,
    emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) return User();

    return User(
      id: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }
}
