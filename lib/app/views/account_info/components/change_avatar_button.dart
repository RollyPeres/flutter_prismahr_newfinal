import 'package:flutter/material.dart';

class ChangeAvatarButton extends StatelessWidget {
  const ChangeAvatarButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(Icons.camera_alt, color: Colors.white, size: 14),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
