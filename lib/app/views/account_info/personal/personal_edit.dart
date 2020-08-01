import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/personal_edit/personal_edit_bloc.dart';
import 'package:flutter_prismahr/app/components/dropdown.dart';
import 'package:flutter_prismahr/app/components/form_group.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/form_input_datetime.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_edit_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/personal_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/personal_repository.dart';
import 'package:flutter_prismahr/utils/request.dart';
import 'package:intl/intl.dart';

class PersonalEditScreen extends StatefulWidget {
  final PersonalModel data;

  const PersonalEditScreen({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _PersonalEditScreenState createState() => _PersonalEditScreenState();
}

class _PersonalEditScreenState extends State<PersonalEditScreen> {
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthplaceController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _marstatController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idExpiryDateController = TextEditingController();
  final TextEditingController _addrController = TextEditingController();
  final TextEditingController _addrCurrentController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final FocusNode _genderFN = FocusNode();
  final FocusNode _birthplaceFN = FocusNode();
  final FocusNode _birthdateFN = FocusNode();
  final FocusNode _marstatFN = FocusNode();
  final FocusNode _religionFN = FocusNode();
  final FocusNode _bloodTypeFN = FocusNode();
  final FocusNode _idNumberFN = FocusNode();
  final FocusNode _idTypeFN = FocusNode();
  final FocusNode _idExpiryDateFN = FocusNode();
  final FocusNode _addrFN = FocusNode();
  final FocusNode _addrCurrentFN = FocusNode();
  final FocusNode _postcodeFN = FocusNode();

  PersonalEditBloc _personalEditBloc;
  PersonalModel get _data => widget.data;
  PersonalEditValidationException _validationException;

  @override
  void initState() {
    super.initState();
    _personalEditBloc = PersonalEditBloc(
        repository: PersonalRepository(
            provider: PersonalProvider(httpClient: Request.dio)));

    _validationException = PersonalEditValidationException();

    _birthdateController.text = _data.birthdate != null
        ? DateFormat.yMMMMd()
            .format(DateFormat('yyyy-MM-dd').parse(_data.birthdate))
        : _data.birthdate;

    _idExpiryDateController.text = _data.idExpiryDate != null
        ? DateFormat.yMMMMd()
            .format(DateFormat('yyyy-MM-dd').parse(_data.idExpiryDate))
        : _data.idExpiryDate;

    _genderController.text = _data.gender;
    _birthplaceController.text = _data.birthplace;
    _marstatController.text = _data.maritalStatus;
    _religionController.text = _data.religion;
    _bloodTypeController.text = _data.bloodType;
    _idNumberController.text = _data.idNumber.toString();
    _idTypeController.text = _data.idType;
    _addrController.text = _data.address;
    _addrCurrentController.text = _data.addressCurrent;
    _postcodeController.text = _data.postcode.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Personal Info')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 57),
        child: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Dropdown(
                      label: 'Gender',
                      value: _genderController.text,
                      errorText: _validationException.gender?.first,
                      items: <DropdownMenuItem<dynamic>>[
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _validationException.gender = null;
                          _genderController.text = val;
                        });
                      },
                    ),
                    FormInputDateTime(
                      controller: _birthdateController,
                      label: 'Birth date',
                      initialDate: _data.birthdate,
                      lastDate: DateTime.now(),
                      errorText: _validationException.birthdate?.first,
                      onDateSelected: (DateTime date) {
                        if (date == null) return;

                        setState(() {
                          _validationException.birthdate = null;
                          _birthdateController.text =
                              DateFormat.yMMMMd().format(date);
                        });
                      },
                    ),
                    FormInput(
                      controller: _birthplaceController,
                      label: 'Birth place',
                      focusNode: _birthplaceFN,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorText: _validationException.birthplace?.first,
                      onChanged: (value) {
                        setState(() {
                          _validationException.birthplace = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _marstatFN.requestFocus();
                      },
                    ),
                  ],
                ),
              ),
              FormGroup(
                label: 'Status & Health',
                children: <Widget>[
                  FormInput(
                    controller: _marstatController,
                    label: 'Marital status',
                    focusNode: _marstatFN,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.maritalStatus?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.maritalStatus = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _religionFN.requestFocus();
                    },
                  ),
                  FormInput(
                    controller: _religionController,
                    label: 'Religion',
                    focusNode: _religionFN,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.religion?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.religion = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _bloodTypeFN.requestFocus();
                    },
                  ),
                  FormInput(
                    controller: _bloodTypeController,
                    label: 'Blood type (optional)',
                    focusNode: _bloodTypeFN,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.bloodType?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.bloodType = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _idNumberFN.requestFocus();
                    },
                  ),
                ],
              ),
              FormGroup(
                label: 'Identity',
                children: <Widget>[
                  FormInput(
                    controller: _idNumberController,
                    label: 'Number',
                    focusNode: _idNumberFN,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.idNumber?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.idNumber = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _idTypeFN.requestFocus();
                    },
                  ),
                  Dropdown(
                    label: 'Type',
                    value: _idTypeController.text,
                    errorText: _validationException.idType?.first,
                    items: <DropdownMenuItem<dynamic>>[
                      DropdownMenuItem(value: 'KTP', child: Text('KTP')),
                      DropdownMenuItem(value: 'SIM', child: Text('SIM')),
                      DropdownMenuItem(
                          value: 'Passport', child: Text('Passport')),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _validationException.idType = null;
                        _idTypeController.text = val;
                      });
                    },
                  ),
                  FormInputDateTime(
                    controller: _idExpiryDateController,
                    label: 'Expiration date',
                    initialDate: _data.idExpiryDate,
                    errorText: _validationException.idExpiryDate?.first,
                    onDateSelected: (DateTime date) {
                      if (date == null) return;

                      setState(() {
                        _validationException.birthdate = null;
                        _idExpiryDateController.text =
                            DateFormat.yMMMMd().format(date);
                      });
                    },
                  ),
                ],
              ),
              FormGroup(
                label: 'Residence',
                children: <Widget>[
                  FormInput(
                    controller: _addrController,
                    label: 'Address',
                    focusNode: _addrFN,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.address?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.address = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _addrCurrentFN.requestFocus();
                    },
                    maxLines: 4,
                  ),
                  FormInput(
                    controller: _addrCurrentController,
                    label: 'Current address',
                    focusNode: _addrCurrentFN,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.addressCurrent?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.addressCurrent = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _postcodeFN.requestFocus();
                    },
                    maxLines: 4,
                  ),
                  FormInput(
                    controller: _postcodeController,
                    label: 'Postal code',
                    focusNode: _postcodeFN,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.postcode?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.postcode = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _submit();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _personalEditBloc,
        child: BlocListener<PersonalEditBloc, PersonalEditState>(
          listener: (context, state) {
            if (state is PersonalEditInvalid) {
              setState(() {
                _validationException = state.exception;
              });
            }

            if (state is PersonalEditFailure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Can't communicate with the server, "
                  "make sure you're connected to the internet.",
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }

            if (state is PersonalEditSuccess) {
              Navigator.of(context).pop(state.data);
            }
          },
          child: BlocBuilder<PersonalEditBloc, PersonalEditState>(
            builder: (context, state) {
              return FloatingActionButton(
                tooltip: 'Save changes',
                child: state is PersonalEditLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Icon(Icons.send),
                onPressed: state is PersonalEditLoading ? null : _submit,
              );
            },
          ),
        ),
      ),
    );
  }

  void unfocus() {
    _genderFN.unfocus();
    _birthplaceFN.unfocus();
    _birthdateFN.unfocus();
    _marstatFN.unfocus();
    _religionFN.unfocus();
    _bloodTypeFN.unfocus();
    _idNumberFN.unfocus();
    _idTypeFN.unfocus();
    _idExpiryDateFN.unfocus();
    _addrFN.unfocus();
    _addrCurrentFN.unfocus();
    _postcodeFN.unfocus();
  }

  void _submit() {
    this.unfocus();

    _personalEditBloc.add(PersonalEditSubmitButtonPressed(
      gender: _genderController.text,
      birthplace: _birthplaceController.text,
      birthdate: _birthdateController.text,
      maritalStatus: _marstatController.text,
      religion: _religionController.text,
      bloodType: _bloodTypeController.text,
      idNumber: _idNumberController.text,
      idType: _idTypeController.text,
      idExpiryDate: _idExpiryDateController.text,
      address: _addrController.text,
      addressCurrent: _addrCurrentController.text,
      postcode: _postcodeController.text,
    ));
  }

  @override
  void dispose() {
    _personalEditBloc.close();
    super.dispose();
  }
}
