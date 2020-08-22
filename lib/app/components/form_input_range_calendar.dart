import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';

class FormInputRangeCalendar extends StatefulWidget {
  FormInputRangeCalendar({
    Key key,
    this.startDateInputLabel,
    this.startDateInputHintText,
    this.startDateInputErrorText,
    this.endDateInputLabel,
    this.endDateInputHintText,
    this.endDateInputErrorText,
    this.initialDateRange,
    @required this.firstDate,
    @required this.lastDate,
    @required this.onChanged,
  }) : super(key: key);

  final String startDateInputLabel;

  final String startDateInputHintText;

  final String startDateInputErrorText;

  final String endDateInputLabel;

  final String endDateInputHintText;

  final String endDateInputErrorText;

  final DateTimeRange initialDateRange;

  final DateTime firstDate;

  final DateTime lastDate;

  final ValueChanged<DateTimeRange> onChanged;

  @override
  _FormInputRangeCalendarState createState() => _FormInputRangeCalendarState();
}

class _FormInputRangeCalendarState extends State<FormInputRangeCalendar> {
  TextEditingController _startDateInputController;
  TextEditingController _endDateInputController;
  MaterialLocalizations _localizations;
  TextDirection _textDirection;

  @override
  void initState() {
    super.initState();
    _startDateInputController = TextEditingController();
    _endDateInputController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);

    if (widget.initialDateRange != null) {
      _startDateInputController.text =
          _localizations.formatShortMonthDay(widget.initialDateRange.start);

      _endDateInputController.text =
          _localizations.formatShortMonthDay(widget.initialDateRange.end);
    }
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final DateTimeRange value = await showDateRangePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDateRange: widget.initialDateRange,
      fieldStartLabelText: widget.startDateInputLabel,
      fieldStartHintText: widget.startDateInputHintText,
      fieldEndLabelText: widget.endDateInputLabel,
      fieldEndHintText: widget.endDateInputHintText,
    );

    if (value != null) _handleChanges(value);
  }

  void _handleChanges(DateTimeRange value) {
    SemanticsService.announce(
      _localizations.formatMonthYear(value.start),
      _textDirection,
    );

    SemanticsService.announce(
      _localizations.formatMonthYear(value.end),
      _textDirection,
    );

    setState(() {
      _startDateInputController.text =
          _localizations.formatShortMonthDay(value.start);

      _endDateInputController.text =
          _localizations.formatShortMonthDay(value.end);
    });

    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: GestureDetector(
            child: AbsorbPointer(
              child: FormInput(
                controller: _startDateInputController,
                label: widget.startDateInputLabel,
                hintText: widget.startDateInputHintText,
                prefixIcon: Icon(Icons.calendar_today),
                errorText: widget.startDateInputErrorText,
              ),
            ),
            onTap: () {
              _showDateRangePicker(context);
            },
          ),
        ),
        // Give some space between fields so it doesn't stick to each other.
        SizedBox(width: 10),
        Flexible(
          child: GestureDetector(
            child: AbsorbPointer(
              child: FormInput(
                controller: _endDateInputController,
                readOnly: true,
                label: widget.endDateInputLabel,
                hintText: widget.endDateInputHintText,
                prefixIcon: Icon(Icons.calendar_today),
                errorText: widget.endDateInputErrorText,
              ),
            ),
            onTap: () {
              _showDateRangePicker(context);
            },
          ),
        ),
      ],
    );
  }
}
