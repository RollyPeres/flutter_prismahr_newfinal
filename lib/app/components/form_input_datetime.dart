import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/themes/themes.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
// ignore: implementation_imports
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
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
    final ThemeMode currentTheme =
        BlocProvider.of<ThemeBloc>(context).state.themeMode;

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
        DateTime date = await showRoundedDatePicker(
          context: context,
          borderRadius: 20,
          initialDate: this.initialDate != null
              ? DateFormat('yyyy-MM-dd').parse(this.initialDate)
              : DateTime.now(),
          firstDate: this.firstDate ?? DateTime(1900),
          lastDate: this.lastDate,
          customWeekDays: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"],
          styleDatePicker: MaterialRoundedDatePickerStyle(
            sizeArrow: 0,
            paddingDatePicker: EdgeInsets.all(13),
            paddingMonthHeader: EdgeInsets.symmetric(vertical: 7),
            decorationDateSelected: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            textStyleMonthYearHeader: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textStyleDayOnCalendarSelected: TextStyle(
              color: Colors.white,
            ),
          ),
          theme: currentTheme == ThemeMode.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
        );
        onDateSelected(date);
      },
    );
  }
}
