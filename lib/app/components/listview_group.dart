import 'package:flutter/material.dart';

class ListViewGroup extends StatelessWidget {
  final Widget title;
  final List<Widget> items;

  const ListViewGroup({
    Key key,
    this.title,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.title == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: this.title,
                ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: this.items.length,
            itemBuilder: (BuildContext context, int index) {
              return this.items[index];
            },
          ),
        ],
      ),
    );
  }
}
