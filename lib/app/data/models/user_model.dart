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

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.avatar = json['avatar'];
    this.name = json['name'];
    this.email = json['email'];
    this.emailVerifiedAt = json['email_verified_at'];
  }
}
