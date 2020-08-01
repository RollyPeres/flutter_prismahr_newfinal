import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const AnnouncementCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 33),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '${this.title}',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            subtitle: Text(
              '${this.subtitle}',
              style: TextStyle(color: Color(0xff9d99b9)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                'Read More',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: this.onTap,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
