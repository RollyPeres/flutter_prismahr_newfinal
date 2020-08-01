import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/personal_edit/personal_edit_bloc.dart';
import 'package:flutter_prismahr/app/components/form_group.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_edit_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/personal_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/personal_repository.dart';
import 'package:flutter_prismahr/utils/request.dart';

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

    _genderController.text = _data.gender;
    _birthplaceController.text = _data.birthplace;
    _birthdateController.text = _data.birthdate;
    _marstatController.text = _data.maritalStatus;
    _religionController.text = _data.religion;
    _bloodTypeController.text = _data.bloodType;
    _idNumberController.text = _data.idNumber.toString();
    _idTypeController.text = _data.idType;
    _idExpiryDateController.text = _data.idExpiryDate;
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
                    FormInput(
                      controller: _genderController,
                      label: 'Gender',
                      focusNode: _genderFN,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorText: _validationException.gender?.first,
                      onChanged: (value) {
                        setState(() {
                          _validationException.gender = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _birthdateFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _birthdateController,
                      label: 'Birth date',
                      focusNode: _birthdateFN,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorText: _validationException.birthdate?.first,
                      onChanged: (value) {
                        setState(() {
                          _validationException.birthdate = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _birthplaceFN.requestFocus();
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
                  FormInput(
                    controller: _idTypeController,
                    label: 'Type',
                    focusNode: _idTypeFN,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.idType?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.idType = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _idExpiryDateFN.requestFocus();
                    },
                  ),
                  FormInput(
                    controller: _idExpiryDateController,
                    label: 'Expiration date',
                    focusNode: _idExpiryDateFN,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    errorText: _validationException.idExpiryDate?.first,
                    onChanged: (value) {
                      setState(() {
                        _validationException.idExpiryDate = null;
                      });
                    },
                    onFieldSubmitted: (_) {
                      _addrFN.requestFocus();
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
      idNumber: int.parse(_idNumberController.text),
      idType: _idTypeController.text,
      idExpiryDate: _idExpiryDateController.text,
      address: _addrController.text,
      addressCurrent: _addrCurrentController.text,
      postcode: int.parse(_postcodeController.text),
    ));
  }

  @override
  void dispose() {
    _personalEditBloc.close();
    super.dispose();
  }
}