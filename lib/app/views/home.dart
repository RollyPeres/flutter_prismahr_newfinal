import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/views/widgets/home/announcement_card.dart';
import 'package:flutter_prismahr/app/views/widgets/home/bottom_navbar.dart';
import 'package:flutter_prismahr/app/views/widgets/home/header.dart';
import 'package:flutter_prismahr/app/views/widgets/home/menu_grid.dart';
import 'package:flutter_prismahr/app/views/widgets/home/performance_chart.dart';
import 'package:flutter_prismahr/app/views/widgets/home/week_counter.dart';

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
