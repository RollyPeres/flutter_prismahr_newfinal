class ContactFormValidationException {
  List relation;
  List name;
  List phone;
  List phoneAlt;

  ContactFormValidationException({relation, name, phone, phoneAlt});

  ContactFormValidationException.fromJson(Map<String, dynamic> json) {
    this.relation = json['relation'];
    this.name = json['name'];
    this.phone = json['phone'];
    this.phoneAlt = json['phone_alt'];
  }
}
