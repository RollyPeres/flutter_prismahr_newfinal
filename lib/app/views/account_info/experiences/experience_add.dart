import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/experience/experience_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/experience_create/experience_create_bloc.dart';
import 'package:flutter_prismahr/app/components/dropdown.dart';
import 'package:flutter_prismahr/app/components/form_checkbox.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_country.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_currency.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_industry.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_position_level.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_specialization.dart';
import 'package:flutter_prismahr/app/components/form_dropdown_workfield.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/country_model.dart';
import 'package:flutter_prismahr/app/data/models/currency_model.dart';
import 'package:flutter_prismahr/app/data/models/industry_model.dart';
import 'package:flutter_prismahr/app/data/models/position_level_model.dart';
import 'package:flutter_prismahr/app/data/models/specialization_model.dart';
import 'package:flutter_prismahr/app/data/models/workfield_model.dart';

class ExperienceAddScreen extends StatefulWidget {
  ExperienceAddScreen({Key key}) : super(key: key);

  @override
  _ExperienceAddScreenState createState() => _ExperienceAddScreenState();
}

class _ExperienceAddScreenState extends State<ExperienceAddScreen> {
  final TextEditingController _companyCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _periodStartYearCtrl = TextEditingController();
  final TextEditingController _periodStartMonthCtrl = TextEditingController();
  final TextEditingController _periodEndYearCtrl = TextEditingController();
  final TextEditingController _periodEndMonthCtrl = TextEditingController();
  final TextEditingController _presentCtrl = TextEditingController();
  final TextEditingController _specializationCtrl = TextEditingController();
  final TextEditingController _workfieldCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _industryCtrl = TextEditingController();
  final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _salaryCurrencyCtrl = TextEditingController();
  final TextEditingController _salaryCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  final FocusNode _companyFN = FocusNode();
  final FocusNode _positionFN = FocusNode();
  final FocusNode _periodStartYearFN = FocusNode();
  final FocusNode _periodEndYearFN = FocusNode();
  final FocusNode _periodEndMonthFN = FocusNode();
  final FocusNode _salaryFN = FocusNode();
  final FocusNode _descriptionFN = FocusNode();

  Country _selectedCountry;
  Currency _selectedCurrency;
  Industry _selectedIndustry;
  PositionLevel _selectedPositionLevel;
  Specialization _selectedSpecialization;
  Workfield _selectedWorkfield;
  ExperienceBloc _experienceBloc;
  ExperienceCreateBloc _experienceCreateBloc;
  ExperienceFormValidationException _errors;
  List<Workfield> _workfields;

  @override
  void initState() {
    _experienceBloc = ExperienceBloc();
    _experienceCreateBloc = ExperienceCreateBloc();
    _errors = ExperienceFormValidationException();
    _workfields = List<Workfield>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool workPeriodIsPresent = _presentCtrl.text.toLowerCase() == 'true';

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(
              'Add Experience',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    FormInput(
                      autofocus: true,
                      controller: _positionCtrl,
                      focusNode: _positionFN,
                      label: 'Position',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.position = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _companyFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _companyCtrl,
                      focusNode: _companyFN,
                      label: 'Company Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.company = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _periodStartYearFN.requestFocus();
                      },
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          child: FormInput(
                            controller: _periodStartYearCtrl,
                            focusNode: _periodStartYearFN,
                            label: 'Working In Here From',
                            hintText: 'Year',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                _errors.periodStartYear = null;
                              });
                            },
                            onFieldSubmitted: (_) {
                              _periodEndYearFN.requestFocus();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Dropdown(
                            label: '',
                            value: _periodStartMonthCtrl.text == ''
                                ? null
                                : _periodStartMonthCtrl.text,
                            hintText: 'Month',
                            errorText: _errors.periodStartMonth?.first,
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
                                _errors.periodStartMonth = null;
                                _periodStartMonthCtrl.text = val;
                              });
                              _periodStartYearFN.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    workPeriodIsPresent
                        ? SizedBox()
                        : Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              Flexible(
                                child: FormInput(
                                  controller: _periodEndYearCtrl,
                                  focusNode: _periodEndYearFN,
                                  label: 'Until',
                                  hintText: 'Year',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    setState(() {
                                      _errors.periodEndYear = null;
                                    });
                                  },
                                  onFieldSubmitted: (_) {
                                    _periodEndMonthFN.requestFocus();
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Dropdown(
                                  label: '',
                                  value: _periodEndMonthCtrl.text == ''
                                      ? null
                                      : _periodEndMonthCtrl.text,
                                  hintText: 'Month',
                                  errorText: _errors.periodEndMonth?.first,
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
                                      _errors.periodEndMonth = null;
                                      _periodEndMonthCtrl.text = val;
                                    });
                                    _periodEndYearFN.requestFocus();
                                  },
                                ),
                              ),
                            ],
                          ),
                    FormCheckbox(
                      label: 'I\'m still working in this company',
                      value: workPeriodIsPresent,
                      onChanged: (bool present) {
                        setState(() {
                          _presentCtrl.text = present.toString();
                        });
                      },
                    ),
                    FormDropdownSpecialization(
                      label: 'Specialization',
                      selectedItem: _selectedSpecialization,
                      onChanged: (Specialization specialization) {
                        setState(() {
                          _errors.specialization = null;
                          _selectedSpecialization = specialization;
                          _specializationCtrl.text = specialization.name;
                          _workfields = specialization.workfields;
                          _selectedWorkfield = null;
                          _workfieldCtrl.clear();
                        });
                      },
                    ),
                    FormDropdownWorkfield(
                      label: 'Working Field',
                      selectedItem: _selectedWorkfield,
                      items: _workfields,
                      onChanged: (Workfield workfield) {
                        setState(() {
                          _errors.workfield = null;
                          _selectedWorkfield = workfield;
                          _workfieldCtrl.text = workfield.name;
                        });
                      },
                    ),
                    FormDropdownCountry(
                      label: 'Country',
                      selectedItem: _selectedCountry,
                      onChanged: (Country country) {
                        setState(() {
                          _errors.country = null;
                          _selectedCountry = country;
                          _countryCtrl.text = country.name;
                        });
                      },
                    ),
                    FormDropdownIndustry(
                      label: 'Industry',
                      selectedItem: _selectedIndustry,
                      onChanged: (Industry industry) {
                        setState(() {
                          _errors.industry = null;
                          _selectedIndustry = industry;
                          _industryCtrl.text = industry.name;
                        });
                      },
                    ),
                    FormDropdownPositionLevel(
                      label: 'Position Level',
                      selectedItem: _selectedPositionLevel,
                      onChanged: (PositionLevel positionLevel) {
                        setState(() {
                          _errors.role = null;
                          _selectedPositionLevel = positionLevel;
                          _roleCtrl.text = positionLevel.name;
                        });
                      },
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Flexible(
                          child: FormDropdownCurrency(
                            label: 'Salary (optional)',
                            hintText: 'Currency',
                            selectedItem: _selectedCurrency,
                            onChanged: (Currency currency) {
                              setState(() {
                                _errors.role = null;
                                _selectedCurrency = currency;
                                _salaryCurrencyCtrl.text = currency.code;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          flex: 2,
                          child: FormInput(
                            controller: _salaryCtrl,
                            focusNode: _salaryFN,
                            label: '',
                            hintText: 'Nominal',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                _errors.salary = null;
                              });
                            },
                            onFieldSubmitted: (_) {
                              _periodEndMonthFN.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                    FormInput(
                      controller: _descriptionCtrl,
                      focusNode: _descriptionFN,
                      label: 'Job Description (optional)',
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textInputAction: TextInputAction.go,
                      onChanged: (value) {
                        setState(() {
                          _errors.description = null;
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
        create: (context) => _experienceCreateBloc,
        child: BlocListener<ExperienceCreateBloc, ExperienceCreateState>(
          listener: (context, state) {
            if (state is ExperienceCreateInvalid) {
              setState(() {
                _errors = state.exception;
              });
            }

            if (state is ExperienceCreateFailure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Can't communicate with the server, "
                  "make sure you're connected to the internet.",
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }

            if (state is ExperienceCreateSuccess) {
              Navigator.of(context).pop(state.data);
            }
          },
          child: BlocBuilder<ExperienceCreateBloc, ExperienceCreateState>(
            builder: (context, state) {
              return FloatingActionButton(
                tooltip: 'Save Experience',
                child: state is ExperienceCreateLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Icon(Icons.save),
                onPressed: state is ExperienceCreateLoading ? null : _submit,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _experienceBloc.close();
    _experienceCreateBloc.close();
    super.dispose();
  }

  void _submit() {
    this.unfocus();
    _experienceCreateBloc.add(ExperienceCreateSubmitButtonPressed(
      company: _companyCtrl.text,
      position: _positionCtrl.text,
      periodStartYear: _periodStartYearCtrl.text,
      periodStartMonth: _periodStartMonthCtrl.text,
      periodEndYear: _periodEndYearCtrl.text,
      periodEndMonth: _periodEndMonthCtrl.text,
      present: _presentCtrl.text,
      specialization: _specializationCtrl.text,
      workfield: _workfieldCtrl.text,
      country: _countryCtrl.text,
      industry: _industryCtrl.text,
      role: _roleCtrl.text,
      salaryCurrency: _salaryCurrencyCtrl.text,
      salary: _salaryCtrl.text,
      description: _descriptionCtrl.text,
    ));
  }

  void unfocus() {
    _companyFN.unfocus();
    _positionFN.unfocus();
    _periodStartYearFN.unfocus();
    _periodEndYearFN.unfocus();
    _periodEndMonthFN.unfocus();
    _salaryFN.unfocus();
    _descriptionFN.unfocus();
  }
}
