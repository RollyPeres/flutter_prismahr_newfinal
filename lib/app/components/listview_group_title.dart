import 'package:flutter/material.dart';

class ListViewGroupTitle extends StatelessWidget {
  final String title;

  const ListViewGroupTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        '${this.title}',
        style: TextStyle(fontSize: 12, color: Color(0xff707070)),
      ),
    );
  }
}
