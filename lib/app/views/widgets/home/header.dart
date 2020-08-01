import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/badge.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Badge(
                  color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text('1',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
              Badge(
                color: Colors.orange,
                child: Text('SP1',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
          GestureDetector(
            child: RoundedRectangleAvatar(),
            onTap: () {
              // TODO: implement route
              // Get.toNamed(Routes.ACCOUNT_INFO);
            },
          ),
        ],
      ),
    );
  }
}
