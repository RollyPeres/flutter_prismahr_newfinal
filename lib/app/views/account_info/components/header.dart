import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/views/account_info/components/change_avatar_button.dart';

class ProfileHeader extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String role;
  final String company;

  const ProfileHeader({
    Key key,
    this.avatarUrl,
    @required this.username,
    @required this.role,
    @required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 37),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                RoundedRectangleAvatar(
                  url: this.avatarUrl,
                  height: 100,
                  width: 100,
                ),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: ChangeAvatarButton(),
                ),
              ],
            ),
          ),
          Text(
            "${this.username}",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            "${this.role} at ${this.company}",
            style: TextStyle(color: Color(0xff9d99b9)),
          ),
        ],
      ),
    );
  }
}
