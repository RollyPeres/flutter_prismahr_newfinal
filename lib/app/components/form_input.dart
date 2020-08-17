import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final FocusNode focusNode;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String initialValue;
  final String label;
  final String errorText;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function onChanged;
  final Function onFieldSubmitted;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final TextEditingController controller;

  const FormInput({
    Key key,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.initialValue,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLines,
    this.minLines,
    this.maxLength,
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
            readOnly: this.readOnly,
            autofocus: this.autofocus,
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
              fillColor: Theme.of(context).cardColor,
              hintText: this.hintText,
              suffixIcon: this.suffixIcon,
              prefixIcon: this.prefixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            ),
            keyboardType: this.keyboardType,
            obscureText: this.obscureText,
            onChanged: this.onChanged,
            textInputAction: this.textInputAction,
            minLines: this.minLines,
            maxLines: this.obscureText != null && this.obscureText
                ? 1
                : this.maxLines,
            maxLength: this.maxLength,
            onFieldSubmitted: this.onFieldSubmitted,
          ),
        ],
      ),
    );
  }
}
