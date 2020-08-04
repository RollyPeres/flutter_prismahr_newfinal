import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_model.dart';

class EducationCard extends StatelessWidget {
  final EducationModel education;

  const EducationCard({
    Key key,
    @required this.education,
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
            EducationCardTitle(
              title: '${education.institution}',
              subtitle:
                  '${education.qualification.toUpperCase()} in ${education.fieldOfStudy}',
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
                        'Graduation Date',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${education.graduationYear}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Major',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${education.majors}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'GCPA',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${education.finalScore}')),
                    ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: education.additionalInfo != null
                  ? Text('${education.additionalInfo}')
                  : Text('No additional information.'),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationCardTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const EducationCardTitle({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.title.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          Text(this.subtitle),
        ],
      ),
    );
  }
}
