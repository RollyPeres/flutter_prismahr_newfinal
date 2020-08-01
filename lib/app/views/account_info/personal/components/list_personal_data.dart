import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_card.dart';
import 'package:flutter_prismahr/app/components/listview_card_group.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:intl/intl.dart';

class ListPersonalData extends StatelessWidget {
  final PersonalModel data;

  const ListPersonalData({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListViewCardGroup(
          title: 'General Information',
          items: <ListViewCardContent>[
            ListViewCardContent(
              label: 'Gender',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.gender ?? 'Not set',
            ),
            ListViewCardContent(
              label: 'Birth Date',
              value: this.data == null
                  ? 'Processing...'
                  : DateFormat.yMMMMd().format(DateFormat('yyyy-MM-dd')
                          .parse(this.data.birthdate)) ??
                      'Not set',
            ),
            ListViewCardContent(
              label: 'Birth Place',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.birthplace ?? 'Not set',
            ),
          ],
        ),
        ListViewCardGroup(
          title: 'Status & Health',
          items: <ListViewCardContent>[
            ListViewCardContent(
              label: 'Marital Status',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.maritalStatus ?? 'Not set',
            ),
            ListViewCardContent(
              label: 'Religion',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.religion ?? 'Not set',
            ),
            ListViewCardContent(
              label: 'Blood Type',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.bloodType ?? 'Not set',
            ),
          ],
        ),
        ListViewCardGroup(
          title: 'Identity',
          items: <ListViewCardContent>[
            ListViewCardContent(
              label: 'Number',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.idNumber?.toString() ?? 'Not set',
            ),
            ListViewCardContent(
              label: 'Type',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.idType ?? 'Not set',
            ),
            ListViewCardContent(
              label: 'Expiration Date',
              value: this.data == null
                  ? 'Processing...'
                  : DateFormat.yMMMMd().format(DateFormat('yyyy-MM-dd')
                          .parse(this.data.idExpiryDate)) ??
                      'Not set',
            ),
            ListViewCardContent(
              label: 'Address',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.address ?? 'Not set',
              extended: true,
            ),
            ListViewCardContent(
              label: 'Current Address',
              value: this.data == null
                  ? 'Processing...'
                  : this.data.addressCurrent ?? 'Not set',
              extended: true,
            ),
          ],
        ),
      ],
    );
  }
}
