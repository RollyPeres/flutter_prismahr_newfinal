class Contact {
  int id;
  String relation;
  String name;
  String phone;
  String phoneAlt;

  Contact({id, relation, name, phone, phoneAlt});

  Contact.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.relation = json['relation'];
    this.name = json['name'];
    this.phone = json['phone'];
    this.phoneAlt = json['phone_alt'];
  }
}
