import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menu extends StatelessWidget {
  final Color color;
  final String asset;
  final String text;
  final Function onTap;
  final double iconHeight;
  final double iconWidth;
  final Color iconColor;

  const Menu({
    Key key,
    this.color,
    this.iconHeight,
    this.iconWidth,
    this.iconColor,
    @required this.asset,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: <Widget>[
            Container(
              height: 50.00,
              width: 50.00,
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: this.color ?? Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.00),
              ),
              child: Center(
                child: SvgPicture.asset(
                  this.asset,
                  height: this.iconHeight ?? 20,
                  width: this.iconWidth ?? 20,
                  color: this.iconColor ?? Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(
              "${this.text}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
