import 'package:flutter/material.dart';

class StackNumberedProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  final double strokeWidth;
  final double value;
  final Color backgroundColor;

  const StackNumberedProgressIndicator({
    Key key,
    this.height,
    this.width,
    this.strokeWidth,
    this.backgroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: this.height ?? 59,
          width: this.width ?? 59,
          child: CircularProgressIndicator(
            strokeWidth: this.strokeWidth ?? 5,
            value: this.value / 100,
            backgroundColor:
                this.backgroundColor ?? Theme.of(context).accentColor,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "${this.value.toInt()}%",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
