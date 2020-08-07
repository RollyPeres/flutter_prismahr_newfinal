class Industry {
  int id;
  String name;

  Industry({id, name});

  Industry.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }
}
