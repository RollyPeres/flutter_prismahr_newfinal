import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final Widget child;

  const Badge({
    Key key,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      decoration: BoxDecoration(
        color: this.color ?? Theme.of(context).primaryColor,
        borderRadius: this.borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: this.child,
    );
  }
}
