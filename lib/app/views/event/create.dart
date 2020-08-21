import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/event_create/event_create_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_prismahr/app/components/form_chips_input.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/event_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';
import 'package:flutter_prismahr/app/data/repositories/user_repository.dart';
import 'package:intl/intl.dart';
import 'package:random_color/random_color.dart';

class EventCreateScreen extends StatefulWidget {
  EventCreateScreen({Key key}) : super(key: key);

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();

  final TextEditingController _locationController = TextEditingController();
  final FocusNode _locationFocus = FocusNode();

  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _detailsFocus = FocusNode();

  List<User> _users;
  List<User> _participants;
  UserRepository _repository;
  DateTime _selectedDate;
  EventCreateBloc _eventCreateBloc;
  EventFormValidationException _errors;

  bool get _currentThemeIsLight =>
      BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _participants = <User>[];
    _users = <User>[];
    _repository = UserRepository();
    _eventCreateBloc = EventCreateBloc();
    _errors = EventFormValidationException();
    _fetchUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _detailsController.dispose();
    _nameFocus.dispose();
    _locationFocus.dispose();
    _detailsFocus.dispose();
    _eventCreateBloc.close();
    super.dispose();
  }

  void _fetchUsers() async {
    final users = await _repository.fetch();
    setState(() {
      _users = users;
    });
  }

  FutureOr<Iterable<User>> _onChipSearchChanged(String query) {
    return _users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) &&
          !_participants.contains(user);
    }).toList(growable: false);
  }

  void _onChipSuggestionSelected(User user) {
    setState(() {
      _participants.add(user);
    });
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    _eventCreateBloc.add(SubmitButtonPressed(
      name: _nameController.text,
      date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      details: _detailsController.text,
      location: _locationController.text,
      participants: _participants.map((p) => p.id).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(title: Text('Create Event')),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CalendarDatePicker(
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 1),
                      initialDate: _selectedDate,
                      onDateChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormInput(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      label: 'Event Name',
                      hintText: 'Holiday in the beach, for free...',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      errorText: _errors.name?.first,
                      onChanged: (_) {
                        setState(() {
                          _errors.name = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormInput(
                      controller: _detailsController,
                      focusNode: _detailsFocus,
                      maxLines: 5,
                      label: 'Event details (optional)',
                      hintText: 'Birthday party of...',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      errorText: _errors.details?.first,
                      onChanged: (_) {
                        setState(() {
                          _errors.details = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormInput(
                      controller: _locationController,
                      focusNode: _locationFocus,
                      minLines: 1,
                      maxLines: 3,
                      label: 'Location (optional)',
                      hintText: 'In the office, second floor...',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      errorText: _errors.location?.first,
                      onChanged: (_) {
                        setState(() {
                          _errors.location = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FormChipsInput<User>(
                      label: 'Participants (optional)',
                      hintText: 'Assign participants',
                      helperText: 'Do not assign anyone to make it public',
                      chipBuilder: _chipBuilder,
                      onSearchChanged: _onChipSearchChanged,
                      onSuggestionSelected: _onChipSuggestionSelected,
                      suggestionsBuilder: _chipsInputSuggestionBuilder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: BlocProvider(
          create: (context) => _eventCreateBloc,
          child: BlocListener<EventCreateBloc, EventCreateState>(
            listener: (context, state) {
              if (state is EventCreateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is EventCreateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is EventCreateFailure) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Oops, something went wrong. "
                    "Make sure you're connected to the internet.",
                  ),
                );

                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: BlocBuilder<EventCreateBloc, EventCreateState>(
              builder: (context, state) {
                return RaisedButton(
                  child: state is EventCreateLoading
                      ? _buildLoadingButtonText()
                      : Text('Publish Event'),
                  onPressed: state is EventCreateLoading ? null : _submit,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipBuilder(
    BuildContext context,
    FormChipsInputState<User> state,
    User user,
  ) {
    final RandomColor randomColor = RandomColor(user.id);
    final Color chipBackgroundColor = _currentThemeIsLight
        ? randomColor.randomMaterialColor().shade50
        : randomColor.randomMaterialColor().shade900;

    return SizedBox(
      width: 122,
      child: Chip(
        backgroundColor: chipBackgroundColor,
        key: ObjectKey(user),
        avatar: RoundedRectangleAvatar(
          url: user.avatar,
          borderRadius: BorderRadius.circular(100),
        ),
        label: Text(user.name),
        onDeleted: () {
          state.chips.remove(user);
          setState(() {
            _participants.remove(user);
          });
        },
      ),
    );
  }

  Widget _chipsInputSuggestionBuilder(
    BuildContext context,
    User user,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 13.0,
      ),
      leading: RoundedRectangleAvatar(
        url: user.avatar,
        height: 45,
        width: 45,
        borderRadius: BorderRadius.circular(100),
      ),
      title: Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: Text(
        'UI/UX Designer',
        style: TextStyle(fontSize: 10, color: Color(0xff707070)),
      ),
    );
  }

  Widget _buildLoadingButtonText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Sending Request...'),
        SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ],
    );
  }
}
