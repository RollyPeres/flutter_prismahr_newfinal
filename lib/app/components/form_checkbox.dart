import 'package:flutter/material.dart';

class FormCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final Function(bool) onChanged;

  const FormCheckbox({
    Key key,
    this.value,
    @required this.label,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Checkbox(
            value: this.value ?? false,
            onChanged: this.onChanged,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(this.label),
          ),
        ],
      ),
    );
  }
}
