class ReimburseType {
  int id;
  String name;

  ReimburseType({id, name});

  ReimburseType.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }
}
