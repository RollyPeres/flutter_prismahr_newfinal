class PersonalEditValidationException {
  List gender;
  List birthplace;
  List birthdate;
  List maritalStatus;
  List religion;
  List bloodType;
  List idNumber;
  List idType;
  List idExpiryDate;
  List address;
  List addressCurrent;
  List postcode;

  PersonalEditValidationException({
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

  PersonalEditValidationException.fromJson(Map<String, dynamic> json) {
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
}
