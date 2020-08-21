class PersonalModel {
  int id;
  String gender;
  String birthplace;
  String birthdate;
  String maritalStatus;
  String religion;
  String bloodType;
  int idNumber;
  String idType;
  String idExpiryDate;
  String address;
  String addressCurrent;
  int postcode;

  PersonalModel({
    this.id,
    this.gender,
    this.birthplace,
    this.birthdate,
    this.maritalStatus,
    this.religion,
    this.bloodType,
    this.idNumber,
    this.idType,
    this.idExpiryDate,
    this.address,
    this.addressCurrent,
    this.postcode,
  });

  factory PersonalModel.fromJson(Map<String, dynamic> json) {
    return PersonalModel(
      id: json['id'],
      gender: json['gender'],
      birthdate: json['birthdate'],
      birthplace: json['birthplace'],
      maritalStatus: json['marital_status'],
      religion: json['religion'],
      bloodType: json['blood_type'],
      idNumber: json['identity_number'],
      idType: json['identity_type'],
      idExpiryDate: json['identity_expiry_date'],
      address: json['address'],
      addressCurrent: json['current_address'],
      postcode: json['postcode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['birthplace'] = this.birthplace;
    data['marital_status'] = this.maritalStatus;
    data['religion'] = this.religion;
    data['blood_type'] = this.bloodType;
    data['identity_number'] = this.idNumber;
    data['identity_type'] = this.idType;
    data['identity_expiry_date'] = this.idExpiryDate;
    data['address'] = this.address;
    data['current_address'] = this.addressCurrent;
    data['postcode'] = this.postcode;
    return data;
  }
}
