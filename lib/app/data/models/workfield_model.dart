class Workfield {
  int id;
  String name;

  Workfield({id, name});

  Workfield.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }
}
