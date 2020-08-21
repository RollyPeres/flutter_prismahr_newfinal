import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  final List<Event> data;

  const EventList({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GroupedListView<Event, String>(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        elements: this.data,
        order: GroupedListOrder.DESC,
        groupBy: (Event event) => event.createdAt.split('T')[0],
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
    Event event,
  ) {
    final RoundedRectangleBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );

    final DateTime date = DateFormat('yyyy-MM-dd').parse(event.date);
    final String formattedDate = DateFormat.yMMMd().format(date);

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
        leading: RoundedRectangleAvatar(url: event.author?.avatar),
        title: Text(
          StringUtils.capitalize(event.name, allWords: true),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        subtitle: Text(
          formattedDate,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {},
      ),
    );
  }
}
