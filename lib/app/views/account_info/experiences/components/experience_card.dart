import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:intl/intl.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({
    Key key,
    @required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String periodStartMonth = DateFormat('MMMM').format(
      DateFormat('M').parse(experience.periodStartMonth.toString()),
    );

    final String periodEndMonth = experience.periodEndMonth != null
        ? DateFormat('MMMM').format(
            DateFormat('M').parse(experience.periodEndMonth.toString()),
          )
        : '';

    final String endPeriod = experience.periodEndMonth != null
        ? '$periodEndMonth ${experience.periodEndYear}'
        : 'Present';

    final String workPeriod =
        '$periodStartMonth ${experience.periodStartYear} -  $endPeriod';

    final String formattedSalaryNominal = experience.salary != null
        ? NumberFormat('###,###,###,###').format(experience.salary)
        : '';

    String salary = '${experience.salaryCurrency} $formattedSalaryNominal';

    if (experience.salaryCurrency == null || experience.salary == null) {
      salary = 'Prefer not to say';
    }

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
                    '${experience.position.toUpperCase()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text('${experience.company} | ${experience.country}')
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
                        'Work Period',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text(workPeriod)),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Industry',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${experience.industry}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Specialization',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${experience.specialization}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Working Field',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${experience.workfield}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Role',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text('${experience.role}')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Monthly Salary',
                        style: TextStyle(color: Color(0xff707070)),
                      )),
                      DataCell(Text(salary)),
                    ]),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: experience.description != null
                        ? Text('${experience.description}')
                        : Text('No additional information.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
