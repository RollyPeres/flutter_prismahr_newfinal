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
    id,
    gender,
    birthplace,
    birthdate,
    maritalStatus,
    religion,
    bloodType,
    idNumber,
    idType,
    idExpiryDate,
    address,
    addressCurrent,
    postcode,
  });

  PersonalModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.gender = json['gender'];
    this.birthdate = json['birthdate'];
    this.birthplace = json['birthplace'];
    this.maritalStatus = json['marital_status'];
    this.religion = json['religion'];
    this.bloodType = json['blood_type'];
    this.idNumber = json['identity_number'];
    this.idType = json['identity_type'];
    this.idExpiryDate = json['identity_expiry_date'];
    this.address = json['address'];
    this.addressCurrent = json['current_address'];
    this.postcode = json['postcode'];
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
