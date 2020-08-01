import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  final String icon;
  final String label;
  final Function onTap;
  final Color iconBackground;
  final double iconHeight;
  final double iconWidth;
  final String progress;
  final Widget trailing;

  const ProfileMenu({
    Key key,
    @required this.icon,
    @required this.label,
    this.onTap,
    this.iconBackground,
    this.iconHeight,
    this.iconWidth,
    this.progress,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            leading: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: this.iconBackground ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  this.icon,
                  height: this.iconHeight ?? 18,
                  width: this.iconWidth ?? 18,
                ),
              ),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "${this.label}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                this.progress != null
                    ? Text(
                        "${this.progress}%",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff9d99b9),
                        ),
                      )
                    : Container()
              ],
            ),
            trailing: this.trailing ?? Icon(Icons.chevron_right),
            onTap: this.onTap,
          ),
        ),
      ),
    );
  }
}
