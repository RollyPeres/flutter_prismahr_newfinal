import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/badge.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class SickleaveList extends StatelessWidget {
  final List<Sickleave> data;

  const SickleaveList({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GroupedListView<Sickleave, String>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        elements: this.data,
        order: GroupedListOrder.DESC,
        groupBy: (Sickleave s) => s.createdAt.split('T')[0],
        groupSeparatorBuilder: (String date) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              date,
              style: Theme.of(context).textTheme.caption,
            ),
          );
        },
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(
    BuildContext context,
    Sickleave sl,
  ) {
    final DateTime from = DateTime.parse(sl.startDate);
    final DateTime to = DateTime.parse(sl.endDate);
    final String formattedFrom = DateFormat.MMMd().format(from);
    final String formattedTo = DateFormat.MMMd().format(to);

    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    Widget badge;

    if (sl.approvedAt != null) {
      badge = _buildBadge(
        context,
        'ACC',
      );
    } else if (sl.rejectedAt != null) {
      badge = _buildBadge(
        context,
        'REJ',
        color: Colors.red,
      );
    } else {
      badge = _buildBadge(
        context,
        'PEN',
        color: Color(0xff9d99b9),
      );
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: shape,
      child: ListTile(
        shape: shape,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13.0,
          vertical: 10.0,
        ),
        leading: Stack(
          overflow: Overflow.visible,
          children: [
            RoundedRectangleAvatar(
              url: sl.applicant.avatar,
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: badge,
            ),
          ],
        ),
        title: Text(
          StringUtils.capitalize(
            sl.reason,
            allWords: true,
          ),
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'From $formattedFrom to $formattedTo',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String status, {Color color}) {
    return Badge(
      color: color,
      padding: const EdgeInsets.symmetric(
        horizontal: 7.0,
        vertical: 3.0,
      ),
      borderRadius: BorderRadius.circular(5.0),
      child: Text(
        status,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontSize: 10, fontWeight: FontWeight.w900),
      ),
    );
  }
}
