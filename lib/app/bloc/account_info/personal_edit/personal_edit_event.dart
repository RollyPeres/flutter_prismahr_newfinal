part of 'personal_edit_bloc.dart';

abstract class PersonalEditEvent extends Equatable {
  const PersonalEditEvent();
}

class PersonalEditSubmitButtonPressed extends PersonalEditEvent {
  final String gender;
  final String birthplace;
  final String birthdate;
  final String maritalStatus;
  final String religion;
  final String bloodType;
  final String idNumber;
  final String idType;
  final String idExpiryDate;
  final String address;
  final String addressCurrent;
  final String postcode;

  const PersonalEditSubmitButtonPressed({
    @required this.gender,
    @required this.birthplace,
    @required this.birthdate,
    @required this.maritalStatus,
    @required this.religion,
    @required this.bloodType,
    @required this.idNumber,
    @required this.idType,
    @required this.idExpiryDate,
    @required this.address,
    @required this.addressCurrent,
    @required this.postcode,
  });

  @override
  List<Object> get props => [
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
      ];

  @override
  String toString() => 'PersonalEditPersonalEditSubmitButtonPressed '
      '{'
      ' gender: $gender,'
      ' birthplace: $birthplace,'
      ' birth_date: $birthdate,'
      ' marital_status: $maritalStatus,'
      ' religion: $religion,'
      ' blood_type: $bloodType,'
      ' id_number: $idNumber,'
      ' id_expiry_date: $idExpiryDate,'
      ' address: $address,'
      ' address_current: $addressCurrent,'
      ' postcode: $postcode, '
      '}';
}
