import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Color color;
  final Widget child;

  const Badge({
    Key key,
    this.color,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: this.color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: this.child,
    );
  }
}
