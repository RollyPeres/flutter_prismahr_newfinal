import 'package:flutter/material.dart';

class WeekCounter extends StatelessWidget {
  final String month;
  final String ordinal;

  const WeekCounter({
    Key key,
    @required this.month,
    @required this.ordinal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10.00),
            child: Text("Attendance Records"),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.00),
            child: Text("${this.month},\n${this.ordinal} Week",
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}
