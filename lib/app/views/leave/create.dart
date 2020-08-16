import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave_create/leave_create_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input_range_calendar.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:intl/intl.dart';

class LeaveCreateScreen extends StatefulWidget {
  LeaveCreateScreen({Key key}) : super(key: key);

  @override
  _LeaveCreateScreenState createState() => _LeaveCreateScreenState();
}

class _LeaveCreateScreenState extends State<LeaveCreateScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _reasonFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();

  DateTimeRange _dateTimeRange;
  LeaveCreateBloc _leaveCreateBloc;
  LeaveFormValidationException _errors;

  @override
  void initState() {
    super.initState();
    _leaveCreateBloc = LeaveCreateBloc();
    _errors = LeaveFormValidationException();
  }

  @override
  void dispose() {
    _leaveCreateBloc.close();
    super.dispose();
  }

  void _handleDateChanges(DateTimeRange dateTimeRange) {
    setState(() {
      _dateTimeRange = dateTimeRange;
    });
  }

  void _submit() async {
    final String startDate = _dateTimeRange != null
        ? DateFormat('yyyy-MM-dd').format(_dateTimeRange.start)
        : '';

    final String endDate = _dateTimeRange != null
        ? DateFormat('yyyy-MM-dd').format(_dateTimeRange.end)
        : '';

    _leaveCreateBloc.add(SubmitButtonPressed(
      reason: _reasonController.text,
      startDate: startDate,
      endDate: endDate,
      details: _detailsController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Request Leave')),
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
          create: (context) => _leaveCreateBloc,
          child: BlocListener<LeaveCreateBloc, LeaveCreateState>(
            listener: (context, state) {
              if (state is LeaveCreateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is LeaveCreateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is LeaveCreateFailure) {
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
            child: BlocBuilder<LeaveCreateBloc, LeaveCreateState>(
              builder: (context, state) {
                return RaisedButton(
                  child: state is LeaveCreateLoading
                      ? _buildLoadingButtonText()
                      : Text('Send Request'),
                  onPressed: state is LeaveCreateLoading ? null : _submit,
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
