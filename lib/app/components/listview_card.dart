import 'package:flutter/material.dart';

class ListViewCard extends StatelessWidget {
  final List<Widget> items;
  final Widget divider;

  const ListViewCard({
    Key key,
    @required this.items,
    this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: this.items.length,
        itemBuilder: (context, index) => this.items[index],
        separatorBuilder: (context, index) => this.divider ?? Divider(),
      ),
    );
  }
}

class ListViewCardContent extends StatelessWidget {
  final String label;
  final String value;
  final bool extended;

  const ListViewCardContent({
    Key key,
    this.extended,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: this.extended != null && this.extended ? _col() : _row(),
    );
  }

  Widget _row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('${this.label}'),
        Text('${this.value}', style: TextStyle(color: Color(0xff9d99b9))),
      ],
    );
  }

  Widget _col() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text('${this.label}'),
        ),
        Text(
          '${this.value}',
          style: TextStyle(color: Color(0xff9d99b9)),
        ),
      ],
    );
  }
}
