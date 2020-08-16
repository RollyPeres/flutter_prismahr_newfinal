import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/sickleave_create/sickleave_create_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input_range_calendar.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/multi_image_picker_component.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_form_validation_exception.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SickleaveCreateScreen extends StatefulWidget {
  SickleaveCreateScreen({Key key}) : super(key: key);

  @override
  _SickleaveCreateScreenState createState() => _SickleaveCreateScreenState();
}

class _SickleaveCreateScreenState extends State<SickleaveCreateScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _reasonFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();

  List<Asset> _receipts;
  DateTimeRange _dateTimeRange;
  SickleaveCreateBloc _sickleaveCreateBloc;
  SickleaveFormValidationException _errors;

  @override
  void initState() {
    super.initState();
    _receipts = const <Asset>[];
    _sickleaveCreateBloc = SickleaveCreateBloc();
    _errors = SickleaveFormValidationException();
  }

  @override
  void dispose() {
    _sickleaveCreateBloc.close();
    super.dispose();
  }

  void _handleImageChanges(List<Asset> images) {
    setState(() {
      _receipts = images;
    });
  }

  void _handleDateChanges(DateTimeRange dateTimeRange) {
    setState(() {
      _dateTimeRange = dateTimeRange;
    });
  }

  void _submit() async {
    List<MultipartFile> receipts = <MultipartFile>[];

    if (_receipts.isNotEmpty) {
      for (var image in _receipts) {
        final ByteData byteData = await image.getByteData(quality: 50);
        final List<int> imageData = byteData.buffer.asUint8List();
        final MultipartFile receipt = MultipartFile.fromBytes(
          imageData,
          filename: image.name,
          contentType: MediaType('image', 'png'),
        );

        receipts.add(receipt);
      }
    }

    final String startDate = _dateTimeRange != null
        ? DateFormat('yyyy-MM-dd').format(_dateTimeRange.start)
        : '';

    final String endDate = _dateTimeRange != null
        ? DateFormat('yyyy-MM-dd').format(_dateTimeRange.end)
        : '';

    _sickleaveCreateBloc.add(SubmitButtonPressed(
      reason: _reasonController.text,
      startDate: startDate,
      endDate: endDate,
      details: _detailsController.text,
      receipts: receipts,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Request Sick Leave')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MultiImagePickerComponent(
                    onImageChanged: _handleImageChanges,
                    subject: "Doctor's Note",
                    maxImages: 3,
                  ),
                  FormInput(
                    controller: _reasonController,
                    focusNode: _reasonFocus,
                    label: 'Reason',
                    hintText: 'Write your reason...',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    errorText: _errors.reason?.first,
                    onChanged: (_) {
                      setState(() {
                        _errors.reason = null;
                      });
                    },
                  ),
                  FormInputRangeCalendar(
                    initialDateRange: _dateTimeRange,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                    startDateInputLabel: 'Start Date',
                    endDateInputLabel: 'End Date',
                    startDateInputHintText: 'mm/dd',
                    endDateInputHintText: 'mm/dd',
                    startDateInputErrorText: _errors.startDate?.first,
                    endDateInputErrorText: _errors.endDate?.first,
                    onChanged: _handleDateChanges,
                  ),
                  FormInput(
                    controller: _detailsController,
                    focusNode: _detailsFocus,
                    label: 'Details',
                    hintText: 'Explain what\'s happening...',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 5,
                    errorText: _errors.details?.first,
                    maxLines: null,
                    onChanged: (_) {
                      setState(() {
                        _errors.details = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: BlocProvider(
          create: (context) => _sickleaveCreateBloc,
          child: BlocListener<SickleaveCreateBloc, SickleaveCreateState>(
            listener: (context, state) {
              if (state is SickleaveCreateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is SickleaveCreateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is SickleaveCreateFailure) {
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
            child: BlocBuilder<SickleaveCreateBloc, SickleaveCreateState>(
              builder: (context, state) {
                return RaisedButton(
                  child: state is SickleaveCreateLoading
                      ? _buildLoadingButtonText()
                      : Text('Send Request'),
                  onPressed: state is SickleaveCreateLoading ? null : _submit,
                );
              },
            ),
          ),
        ),
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
