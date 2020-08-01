import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String label;
  final String hintText;
  final dynamic value;
  final String errorText;
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChanged;

  const Dropdown({
    Key key,
    this.label,
    this.hintText,
    this.value,
    this.errorText,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text('${this.label}'))
              : SizedBox(),
          DropdownButtonFormField(
            isExpanded: true,
            hint: this.hintText != null ? Text('${this.hintText}') : null,
            value: this.value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorText: this.errorText,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
            ),
            items: this.items,
            onChanged: this.onChanged,
          ),
        ],
      ),
    );
  }
}
