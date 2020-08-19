import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/field_report_create/field_report_create_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/multi_image_picker_component.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/field_report_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';
import 'package:flutter_prismahr/app/data/repositories/user_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:random_color/random_color.dart';

class FieldReportCreateScreen extends StatefulWidget {
  FieldReportCreateScreen({Key key}) : super(key: key);

  @override
  _FieldReportCreateScreenState createState() =>
      _FieldReportCreateScreenState();
}

class _FieldReportCreateScreenState extends State<FieldReportCreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  final TextEditingController _chronologyController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _participantFocusNode = FocusNode();
  final FocusNode _chronologyFocusNode = FocusNode();

  final int _maxChips = 6;

  FieldReportCreateBloc _fieldReportCreateBloc;
  FieldReportFormValidationException _errors;

  List<Asset> _images = <Asset>[];
  List<User> _users = <User>[];
  List<User> _participants = <User>[];
  UserRepository _repository = UserRepository();

  bool get _hasReachedMaxChips => _participants.length == _maxChips;
  bool get _currentThemeIsLight =>
      BlocProvider.of<ThemeBloc>(context).state.themeMode == ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _fieldReportCreateBloc = FieldReportCreateBloc();
    _errors = FieldReportFormValidationException();
    _fetchUsers();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _participantController.dispose();
    _chronologyController.dispose();
    _titleFocusNode.dispose();
    _participantFocusNode.dispose();
    _chronologyFocusNode.dispose();
    _fieldReportCreateBloc.close();
    super.dispose();
  }

  void _fetchUsers() async {
    final users = await _repository.fetch();
    setState(() {
      _users = users;
    });
  }

  void _submit() async {
    final List<int> participants = _participants.map((p) => p.id).toList();

    List<MultipartFile> images = <MultipartFile>[];
    for (var image in _images) {
      final ByteData byteData = await image.getByteData(quality: 50);
      final List<int> imageData = byteData.buffer.asUint8List();
      final MultipartFile file = MultipartFile.fromBytes(
        imageData,
        filename: image.name,
        contentType: MediaType('image', 'png'),
      );

      images.add(file);
    }

    _unfocus();
    _fieldReportCreateBloc.add(FieldReportCreateSubmitButtonPressed(
      images: images,
      title: _titleController.text,
      chronology: _chronologyController.text,
      participants: participants,
    ));
  }

  void _unfocus() {
    _titleFocusNode.unfocus();
    _participantFocusNode.unfocus();
    _chronologyFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(title: Text('Add Field Report')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageGridView(),
                      _buildTitleInput(),
                      _buildParticipantInput(),
                      _buildChronologyInput(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _fieldReportCreateBloc,
        child: BlocListener<FieldReportCreateBloc, FieldReportCreateState>(
          listener: (context, state) {
            if (state is FieldReportCreateInvalid) {
              setState(() {
                _errors = state.exception;
              });
            }

            if (state is FieldReportCreateFailure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Can't communicate with the server, "
                  "make sure you're connected to the internet.",
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }

            if (state is FieldReportCreateSuccess) {
              Navigator.of(context).pop(state.data);
            }
          },
          child: BlocBuilder<FieldReportCreateBloc, FieldReportCreateState>(
            builder: (context, state) {
              return FloatingActionButton(
                tooltip: 'Send Field Report',
                child: state is FieldReportCreateLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Icon(Icons.save),
                onPressed: state is FieldReportCreateLoading ? null : _submit,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    return FormInput(
      controller: _titleController,
      focusNode: _titleFocusNode,
      label: 'Title',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      errorText: _errors.title?.first,
      onChanged: (_) {
        setState(() {
          _errors.title = null;
        });
      },
      onFieldSubmitted: (_) {
        _participantFocusNode.requestFocus();
      },
    );
  }

  Widget _buildParticipantInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Participants'),
              Text('${_participants.length} of $_maxChips'),
            ],
          ),
        ),
        Padding(
          padding: _participants.isNotEmpty
              ? const EdgeInsets.only(bottom: 8.0)
              : EdgeInsets.zero,
          child: Wrap(
            spacing: 4.0,
            runSpacing: 0.0,
            children: _participants.map((participant) {
              final RandomColor randomColor = RandomColor(participant.id);
              final Color chipBackgroundColor = _currentThemeIsLight
                  ? randomColor.randomMaterialColor().shade50
                  : randomColor.randomMaterialColor().shade900;

              return SizedBox(
                width: 122,
                child: Chip(
                  backgroundColor: chipBackgroundColor,
                  key: ObjectKey(participant),
                  avatar: RoundedRectangleAvatar(
                    url: participant.avatar,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  label: Text(participant.name),
                  onDeleted: () {
                    setState(() {
                      _participants.remove(participant);
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        !_hasReachedMaxChips
            ? _buildTypeAheadField()
            : Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                child: Text(
                  'Remove at least one of them to show the search input again.',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
      ],
    );
  }

  Widget _buildTypeAheadField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TypeAheadFormField<User>(
        itemBuilder: _itemBuilder,
        debounceDuration: Duration(milliseconds: 500),
        textFieldConfiguration: TextFieldConfiguration(
          controller: _participantController,
          enabled: !_hasReachedMaxChips,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            filled: true,
            hintText: 'Find by user name',
            helperText:
                'This field will dissapear once you reach the maximum tag',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onSuggestionSelected: (User participant) {
          setState(() => _participants.add(participant));
          _participantController.clear();
        },
        suggestionsCallback: (String name) {
          return _users.where((user) {
            return user.name.toLowerCase().contains(name.toLowerCase()) &&
                !_participants.contains(user);
          }).toList(growable: false);
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          elevation: 4.0,
          constraints: BoxConstraints(minHeight: 300, maxHeight: 300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, User user) {
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

  Widget _buildChronologyInput() {
    return FormInput(
      maxLines: 10,
      controller: _chronologyController,
      focusNode: _chronologyFocusNode,
      label: 'Chronology',
      hintText: 'Explain what happened...',
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      errorText: _errors.chronology?.first,
      onChanged: (_) {
        setState(() {
          _errors.chronology = null;
        });
      },
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildImageGridView() {
    return MultiImagePickerComponent(
      subject: 'Image',
      onImageChanged: (List<Asset> images) {
        setState(() {
          _images = images;
        });
      },
    );
  }
}
