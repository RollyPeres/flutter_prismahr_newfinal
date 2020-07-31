import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_card.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:flutter_prismahr/app/components/listview_group_title.dart';

class ListViewCardGroup extends StatelessWidget {
  final String title;
  final List<ListViewCardContent> items;

  const ListViewCardGroup({
    Key key,
    @required this.title,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListViewGroup(
        title: ListViewGroupTitle(title: this.title),
        items: <Widget>[
          ListViewCard(items: this.items),
        ],
      ),
    );
  }
}
