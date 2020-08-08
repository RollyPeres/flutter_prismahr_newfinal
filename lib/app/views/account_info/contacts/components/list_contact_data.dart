import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:flutter_prismahr/app/components/listview_group_title.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/components/contact_card.dart';

class ListContactData extends StatelessWidget {
  final List<Contact> contacts;

  const ListContactData({
    Key key,
    @required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewGroup(
      title: ListViewGroupTitle(title: 'My contacts'),
      items: this
          .contacts
          .map((contact) => ContactCard(contact: contact))
          .toList(),
    );
  }
}
