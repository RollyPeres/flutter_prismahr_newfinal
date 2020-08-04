class Country {
  String name;
  String code;

  Country({this.name, this.code});

  Country.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.code = json['code'];
  }
}
