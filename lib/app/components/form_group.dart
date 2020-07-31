import 'package:flutter/material.dart';

class FormGroup extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const FormGroup({
    Key key,
    @required this.label,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              children: <Widget>[
                Expanded(child: Divider(color: Color(0xff9d99b9))),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    this.label,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Color(0xff9d99b9)),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: this.children,
          ),
        ],
      ),
    );
  }
}
