import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/contact_create/contact_create_bloc.dart';
import 'package:flutter_prismahr/app/components/dropdown.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_form_validation_exception_model.dart';

class ContactAddScreen extends StatefulWidget {
  ContactAddScreen({Key key}) : super(key: key);

  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  final TextEditingController _relationCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _phoneAltCtrl = TextEditingController();

  final FocusNode _relationFN = FocusNode();
  final FocusNode _nameFN = FocusNode();
  final FocusNode _phoneFN = FocusNode();
  final FocusNode _phoneAltFN = FocusNode();

  ContactCreateBloc _contactCreateBloc;
  ContactFormValidationException _errors;

  @override
  void initState() {
    _contactCreateBloc = ContactCreateBloc();
    _errors = ContactFormValidationException();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(
              'Add Contact',
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
                      controller: _nameCtrl,
                      focusNode: _nameFN,
                      label: 'Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.name = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _relationFN.requestFocus();
                      },
                    ),
                    Dropdown(
                      label: 'Relation',
                      value:
                          _relationCtrl.text == '' ? null : _relationCtrl.text,
                      errorText: _errors.relation?.first,
                      items: <DropdownMenuItem<dynamic>>[
                        DropdownMenuItem(
                          value: 'Teman',
                          child: Text('Teman'),
                        ),
                        DropdownMenuItem(
                          value: 'Keluarga',
                          child: Text('Keluarga'),
                        ),
                        DropdownMenuItem(
                          value: 'Saudara',
                          child: Text('Saudara'),
                        ),
                        DropdownMenuItem(
                          value: 'Adik',
                          child: Text('Adik'),
                        ),
                        DropdownMenuItem(
                          value: 'Kakak',
                          child: Text('Kakak'),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _errors.relation = null;
                          _relationCtrl.text = val;
                        });
                        _phoneFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _phoneCtrl,
                      focusNode: _phoneFN,
                      label: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.phone = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _phoneAltFN.requestFocus();
                      },
                    ),
                    FormInput(
                      controller: _phoneAltCtrl,
                      focusNode: _phoneAltFN,
                      label: 'Alternative Phone Number',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {
                          _errors.phoneAlt = null;
                        });
                      },
                      onFieldSubmitted: (_) {
                        _phoneAltFN.requestFocus();
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
        create: (context) => _contactCreateBloc,
        child: BlocListener<ContactCreateBloc, ContactCreateState>(
          listener: (context, state) {
            if (state is ContactCreateInvalid) {
              setState(() {
                _errors = state.exception;
              });
            }

            if (state is ContactCreateFailure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Can't communicate with the server, "
                  "make sure you're connected to the internet.",
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }

            if (state is ContactCreateSuccess) {
              Navigator.of(context).pop(state.data);
            }
          },
          child: BlocBuilder<ContactCreateBloc, ContactCreateState>(
            builder: (context, state) {
              return FloatingActionButton(
                tooltip: 'Save Contact',
                child: state is ContactCreateLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Icon(Icons.save),
                onPressed: state is ContactCreateLoading ? null : _submit,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contactCreateBloc.close();
    super.dispose();
  }

  void _submit() {
    this.unfocus();
    _contactCreateBloc.add(ContactCreateSubmitButtonPressed(
      relation: _relationCtrl.text,
      name: _nameCtrl.text,
      phone: _phoneCtrl.text,
      phoneAlt: _phoneAltCtrl.text,
    ));
  }

  void unfocus() {
    _relationFN.unfocus();
    _nameFN.unfocus();
    _phoneFN.unfocus();
    _phoneAltFN.unfocus();
  }
}
