import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:intl/intl.dart';

class FormInputDateTime extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String errorText;
  final Function onChanged;
  final String initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateSelected;

  const FormInputDateTime({
    Key key,
    this.controller,
    this.label,
    this.errorText,
    this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    @required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AbsorbPointer(
        child: FormInput(
          controller: this.controller,
          readOnly: true,
          label: this.label,
          errorText: this.errorText,
          onChanged: this.onChanged,
        ),
      ),
      onTap: () async {
        DateTime date = await showDatePicker(
          context: context,
          initialDate: this.initialDate != null
              ? DateFormat('yyyy-MM-dd').parse(this.initialDate)
              : DateTime.now().subtract(Duration(seconds: 60)),
          firstDate: this.firstDate ?? DateTime(1900),
          lastDate: this.lastDate ?? DateTime.now(),
        );
        onDateSelected(date);
      },
    );
  }
}
