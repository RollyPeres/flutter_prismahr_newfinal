class FieldOfStudy {
  String name;
  FieldOfStudy({this.name});

  FieldOfStudy.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
  }
}
