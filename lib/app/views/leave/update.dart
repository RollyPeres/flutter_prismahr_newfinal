import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave_update/leave_update_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/form_input_range_calendar.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:intl/intl.dart';

class LeaveUpdateScreen extends StatefulWidget {
  final Leave data;

  LeaveUpdateScreen({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  @override
  _LeaveUpdateScreenState createState() => _LeaveUpdateScreenState();
}

class _LeaveUpdateScreenState extends State<LeaveUpdateScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final FocusNode _reasonFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();

  DateTimeRange _dateTimeRange;
  LeaveUpdateBloc _leaveUpdateBloc;
  LeaveFormValidationException _errors;

  DateTime get startDate =>
      DateFormat('yyyy-MM-dd').parse(widget.data.startDate);

  DateTime get endDate => DateFormat('yyyy-MM-dd').parse(widget.data.endDate);

  @override
  void initState() {
    super.initState();
    _leaveUpdateBloc = BlocProvider.of<LeaveUpdateBloc>(context);
    _errors = LeaveFormValidationException();
    _reasonController.text = widget.data.reason;
    _detailsController.text = widget.data.details;
    _dateTimeRange = DateTimeRange(start: startDate, end: endDate);
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _detailsController.dispose();
    _reasonFocus.dispose();
    _detailsFocus.dispose();
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

    _leaveUpdateBloc.add(SubmitButtonPressed(
      id: widget.data.id,
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
                    firstDate: DateTime(_dateTimeRange.start.year - 1),
                    lastDate: DateTime(_dateTimeRange.end.year + 1),
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
          create: (context) => _leaveUpdateBloc,
          child: BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
            listener: (context, state) {
              if (state is LeaveUpdateInvalid) {
                setState(() {
                  _errors = state.exception;
                });
              }

              if (state is LeaveUpdateSuccess) {
                Navigator.of(context).pop(state.data);
              }

              if (state is LeaveUpdateFailure) {
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
            child: BlocBuilder<LeaveUpdateBloc, LeaveUpdateState>(
              builder: (context, state) {
                return RaisedButton(
                  child: state is LeaveUpdateLoading
                      ? _buildLoadingButtonText()
                      : Text('Update'),
                  onPressed: state is LeaveUpdateLoading ? null : _submit,
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
