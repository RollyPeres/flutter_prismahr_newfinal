import 'package:flutter/material.dart';

import 'components/announcement_card.dart';
import 'components/bottom_navbar.dart';
import 'components/header.dart';
import 'components/menu_grid.dart';
import 'components/performance_chart.dart';
import 'components/week_counter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(),
            WeekCounter(month: 'August', ordinal: '1st'),
            PerformanceChart(),
            Container(
              height: 130,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  AnnouncementCard(
                      onTap: () {},
                      title: 'Covid-19 Alert!',
                      subtitle:
                          'Regardless of the current pandemic, our company decided to '
                          'stop office...'),
                  AnnouncementCard(
                      onTap: () {},
                      title: 'Covid-19 Alert!',
                      subtitle:
                          'Regardless of the current pandemic, our company decided to '
                          'stop office...'),
                  AnnouncementCard(
                      onTap: () {},
                      title: 'Covid-19 Alert!',
                      subtitle:
                          'Regardless of the current pandemic, our company decided to '
                          'stop office...'),
                  AnnouncementCard(
                      onTap: () {},
                      title: 'Covid-19 Alert!',
                      subtitle:
                          'Regardless of the current pandemic, our company decided to '
                          'stop office...'),
                ],
              ),
            ),
            MenuGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
