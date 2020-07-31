import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final bool busy;

  const Button({
    Key key,
    @required this.onPressed,
    @required this.child,
    this.color,
    this.borderRadius,
    this.busy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: this.busy != null && this.busy
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            )
          : this.child,
      color: this.color ?? Theme.of(context).primaryColor,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: this.borderRadius ?? BorderRadius.circular(10)),
    );
  }
}
