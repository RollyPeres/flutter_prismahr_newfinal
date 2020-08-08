import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({
    Key key,
    @required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${contact.name.toUpperCase()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text('${contact.relation}')
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: AbsorbPointer(
                child: DataTable(
                  dividerThickness: 0,
                  headingRowHeight: 0,
                  columns: <DataColumn>[
                    DataColumn(label: Container()),
                    DataColumn(label: Container()),
                  ],
                  rows: <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Phone Number',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${contact.phone}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Phone Number Alternative',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${contact.phoneAlt}')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
