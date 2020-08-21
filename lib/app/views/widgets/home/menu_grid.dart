import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/widgets/home/menu.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.00,
      margin: const EdgeInsets.only(bottom: 20),
      child: GridView.count(
        crossAxisCount: 4,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.00),
        mainAxisSpacing: 10.0,
        children: <Widget>[
          Menu(
            color: Color(0xffff3030),
            asset: 'assets/icons/icon-exclamation-circle.svg',
            text: 'Field Report',
            iconColor: Colors.white,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.FIELD_REPORT);
            },
          ),
          Menu(
            asset: 'assets/icons/icon-calendar-check.svg',
            text: 'Attendance',
            onTap: () {},
          ),
          Menu(
            asset: 'assets/icons/icon-walking.svg',
            text: 'Leave',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.LEAVE);
            },
          ),
          Menu(
            asset: 'assets/icons/icon-hospital.svg',
            text: 'Sick Leave',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.SICKLEAVE);
            },
          ),
          Menu(
            asset: 'assets/icons/icon-branch.svg',
            text: 'Shift',
            onTap: () {},
          ),
          Menu(
            asset: 'assets/icons/icon-calendar.svg',
            text: 'Events',
            onTap: () {
              Navigator.of(context).pushNamed(Routes.EVENT);
            },
          ),
          Menu(
            asset: 'assets/icons/icon-money-check.svg',
            text: 'Reimburse',
            iconHeight: 14,
            iconWidth: 20,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.REIMBURSE);
            },
          ),
          Menu(
            asset: 'assets/icons/icon-money-check-alt.svg',
            text: 'Loan',
            iconHeight: 14,
            iconWidth: 20,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.LOAN);
            },
          ),
        ],
      ),
    );
  }
}
