class PositionLevel {
  int id;
  String name;
  int value;

  PositionLevel({id, name, value});

  PositionLevel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.value = json['value'];
  }
}
