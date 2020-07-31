import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/stacknumbered_progress_indicator.dart';

class CardWithProgressIndicator extends StatelessWidget {
  final double indicatorValue;
  final String title;
  final String subtitle;

  const CardWithProgressIndicator({
    Key key,
    @required this.indicatorValue,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(13),
        leading: StackNumberedProgressIndicator(value: this.indicatorValue),
        title: Text(
          "${this.title}",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
        ),
        subtitle: Text(
          "${this.subtitle}",
          style: TextStyle(fontSize: 12, color: Color(0xff9d99b9)),
        ),
      ),
    );
  }
}
