import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/button.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).cardColor,
      child: Container(
        height: 55,
        color: Theme.of(context).cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            IconButton(
              icon: Icon(Icons.home, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.pie_chart, color: Colors.grey[300]),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.grey[300]),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.ACCOUNT_INFO);
              },
            ),
            Container(),
            SizedBox(
              width: 153,
              height: 60,
              child: Button(
                borderRadius: BorderRadius.circular(0),
                child: Text(
                  'Quick Check In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
