import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final FocusNode focusNode;
  final IconButton suffixIcon;
  final String initialValue;
  final String label;
  final String errorText;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function onChanged;
  final Function onFieldSubmitted;
  final int maxLines;
  final TextEditingController controller;

  const FormInput({
    Key key,
    this.readOnly,
    this.autofocus,
    this.focusNode,
    this.initialValue,
    this.label,
    this.hintText,
    this.obscureText,
    this.errorText,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
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
          TextFormField(
            initialValue: this.initialValue,
            readOnly: this.readOnly ?? false,
            autofocus: this.autofocus ?? false,
            controller: this.controller,
            focusNode: this.focusNode,
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
              hintText: this.hintText,
              suffixIcon: this.suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            ),
            keyboardType: this.keyboardType ?? TextInputType.text,
            obscureText: this.obscureText ?? false,
            onChanged: this.onChanged,
            textInputAction: this.textInputAction ?? TextInputAction.done,
            maxLines: this.maxLines ?? 1,
            onFieldSubmitted: this.onFieldSubmitted,
          ),
        ],
      ),
    );
  }
}
