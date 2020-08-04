import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/education_create/education_create_bloc.dart';
import 'package:flutter_prismahr/app/components/dropdown.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_country.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_field_studies.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/country_model.dart';
import 'package:flutter_prismahr/app/data/models/field_of_study_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/education_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/education_repository.dart';
import 'package:flutter_prismahr/utils/request.dart';

class EducationAddScreen extends StatefulWidget {
  EducationAddScreen({Key key}) : super(key: key);

  @override
  _EducationAddScreenState createState() => _EducationAddScreenState();
}

class _EducationAddScreenState extends State<EducationAddScreen> {
  final TextEditingController _institutionCtrl = TextEditingController();
  final TextEditingController _graduationMonthCtrl = TextEditingController();
  final TextEditingController _graduationYearCtrl = TextEditingController();
  final TextEditingController _qualificationCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _fieldOfStudyCtrl = TextEditingController();
  final TextEditingController _majorsCtrl = TextEditingController();
  final TextEditingController _finalScoreCtrl = TextEditingController();
  final TextEditingController _additionalInfoCtrl = TextEditingController();
  final FocusNode _institutionFN = FocusNode();
  final FocusNode _graduationMonthFN = FocusNode();
  final FocusNode _graduationYearFN = FocusNode();
  final FocusNode _qualificationFN = FocusNode();
  final FocusNode _locationFN = FocusNode();
  final FocusNode _fieldOfStudyFN = FocusNode();
  final FocusNode _majorsFN = FocusNode();
  final FocusNode _finalScoreFN = FocusNode();
  final FocusNode _additionalInfoFN = FocusNode();

  Country _selectedCountry;
  FieldOfStudy _selectedFieldOfStudy;
  EducationCreateBloc _educationCreateBloc;
  EducationFormValidationException _errors;

  @override
  void initState() {
    super.initState();
    _educationCreateBloc = EducationCreateBloc(
        repository: EducationRepository(
            provider: EducationProvider(httpClient: Request.dio)));

    _errors = EducationFormValidationException();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Add education'),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    FormInput(
                      autofocus: true,
                      controller: _institutionCtrl,
                      focusNode: _institutionFN,
                      label: 'Institution name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.institution = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _graduationMonthFN.requestFocus();
                      },
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          child: Dropdown(
                            label: 'Graduation Date',
                            value: _graduationMonthCtrl.text == ''
                                ? null
                                : _graduationMonthCtrl.text,
                            hintText: 'Month',
                            errorText: _errors.graduationMonth?.first,
                            items: <DropdownMenuItem<dynamic>>[
                              DropdownMenuItem(
                                value: '1',
                                child: Text('Jan'),
                              ),
                              DropdownMenuItem(
                                value: '2',
                                child: Text('Feb'),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text('Mar'),
                              ),
                              DropdownMenuItem(
                                value: '4',
                                child: Text('Apr'),
                              ),
                              DropdownMenuItem(
                                value: '5',
                                child: Text('May'),
                              ),
                              DropdownMenuItem(
                                value: '6',
                                child: Text('Jun'),
                              ),
                              DropdownMenuItem(
                                value: '7',
                                child: Text('Jul'),
                              ),
                              DropdownMenuItem(
                                value: '8',
                                child: Text('Aug'),
                              ),
                              DropdownMenuItem(
                                value: '9',
                                child: Text('Sep'),
                              ),
                              DropdownMenuItem(
                                value: '10',
                                child: Text('Oct'),
                              ),
                              DropdownMenuItem(
                                value: '11',
                                child: Text('Nov'),
                              ),
                              DropdownMenuItem(
                                value: '12',
                                child: Text('Dec'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                _errors.graduationMonth = null;
                                _graduationMonthCtrl.text = val;
                              });
                              _graduationYearFN.requestFocus();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: FormInput(
                            controller: _graduationYearCtrl,
                            focusNode: _graduationYearFN,
                            label: '',
                            hintText: 'Year',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                _errors.graduationYear = null;
                              });
                            },
                            onFieldSubmitted: (_) {
                              _qualificationFN.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    Dropdown(
                      label: 'Qualification',
                      value: _qualificationCtrl.text == ''
                          ? null
                          : _qualificationCtrl.text,
                      errorText: _errors.qualification?.first,
                      items: <DropdownMenuItem<dynamic>>[
                        DropdownMenuItem(
                          value: 'SMU/SMK/STM',
                          child: Text('SMU/SMK/STM'),
                        ),
                        DropdownMenuItem(
                          value: 'D3 (Diploma)',
                          child: Text('D3 (Diploma)'),
                        ),
                        DropdownMenuItem(
                          value: 'Sarjana (S1)',
                          child: Text('Sarjana (S1)'),
                        ),
                        DropdownMenuItem(
                          value: 'Magister (S2)',
                          child: Text('Magister (S2)'),
                        ),
                        DropdownMenuItem(
                          value: 'Doktor (S3)',
                          child: Text('Doktor (S3)'),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _errors.qualification = null;
                          _qualificationCtrl.text = val;
                        });
                        _locationFN.requestFocus();
                      },
                    ),
                    FormDropdownCountry(
                      label: 'Country',
                      selectedItem: _selectedCountry,
                      onChanged: (Country country) {
                        setState(() {
                          _errors.location = null;
                          _selectedCountry = country;
                          _locationCtrl.text = country.name;
                        });
                      },
                    ),
                    FormDropdownFieldOfStudy(
                      label: 'Field of Study',
                      selectedItem: _selectedFieldOfStudy,
                      onChanged: (FieldOfStudy field) {
                        setState(() {
                          _errors.fieldOfStudy = null;
                          _selectedFieldOfStudy = field;
                          _fieldOfStudyCtrl.text = field.name;
                        });
                      },
                    ),
                    FormInput(
                      controller: _majorsCtrl,
                      focusNode: _majorsFN,
                      label: 'Majors',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.majors = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _finalScoreFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _finalScoreCtrl,
                      focusNode: _finalScoreFN,
                      label: 'Final Score',
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.finalScore = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _additionalInfoFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _additionalInfoCtrl,
                      focusNode: _additionalInfoFN,
                      label: 'Additional Info (optional)',
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textInputAction: TextInputAction.go,
                      onChanged: (value) {
                        setState(() {
                          _errors.additionalInfo = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _submit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _educationCreateBloc,
        child: BlocListener<EducationCreateBloc, EducationCreateState>(
          listener: (context, state) {
            if (state is EducationCreateInvalid) {
              setState(() {
                _errors = state.exception;
              });
            }

            if (state is EducationCreateFailure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Can't communicate with the server, "
                  "make sure you're connected to the internet.",
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }

            if (state is EducationCreateSuccess) {
              Navigator.of(context).pop(state.data);
            }
          },
          child: BlocBuilder<EducationCreateBloc, EducationCreateState>(
            builder: (context, state) {
              return FloatingActionButton(
                tooltip: 'Save Education',
                child: state is EducationCreateLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Icon(Icons.send),
                onPressed: state is EducationCreateLoading ? null : _submit,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _educationCreateBloc.close();
    super.dispose();
  }

  void _submit() {
    this.unfocus();
    _educationCreateBloc.add(EducationCreateSubmitButtonPressed(
      institution: _institutionCtrl.text,
      graduationMonth: _graduationMonthCtrl.text,
      graduationYear: _graduationYearCtrl.text,
      qualification: _qualificationCtrl.text,
      location: _locationCtrl.text,
      fieldOfStudy: _fieldOfStudyCtrl.text,
      majors: _majorsCtrl.text,
      finalScore: _finalScoreCtrl.text,
      additionalInfo: _additionalInfoCtrl.text,
    ));
  }

  void unfocus() {
    _institutionFN.unfocus();
    _graduationMonthFN.unfocus();
    _graduationYearFN.unfocus();
    _qualificationFN.unfocus();
    _locationFN.unfocus();
    _fieldOfStudyFN.unfocus();
    _majorsFN.unfocus();
    _finalScoreFN.unfocus();
    _additionalInfoFN.unfocus();
  }
}
