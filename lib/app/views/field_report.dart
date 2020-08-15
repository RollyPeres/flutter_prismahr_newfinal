import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/field_report/field_report_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/app/routes/route_arguments.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/field_report/components/field_report_list_loading.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:basic_utils/basic_utils.dart';

class FieldReportScreen extends StatefulWidget {
  FieldReportScreen({Key key}) : super(key: key);

  @override
  _FieldReportScreenState createState() => _FieldReportScreenState();
}

class _FieldReportScreenState extends State<FieldReportScreen> {
  List<FieldReport> _fieldReports = <FieldReport>[];
  FieldReportBloc fieldReportBloc;

  @override
  void initState() {
    fieldReportBloc = FieldReportBloc();
    fieldReportBloc.add(FieldReportScreenInitialized());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text(
              'Field Reports',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => fieldReportBloc,
              child: BlocListener<FieldReportBloc, FieldReportState>(
                listener: (context, state) {
                  if (state is FieldReportLoaded) {
                    setState(() {
                      _fieldReports = state.data;
                    });
                  }

                  if (state is FieldReportCreated) {
                    setState(() {
                      _fieldReports.add(state.data);
                    });
                  }

                  if (state is FieldReportDeleted) {
                    setState(() {
                      _fieldReports.removeWhere((fr) => fr.id == state.data.id);
                    });
                  }
                },
                child: BlocBuilder<FieldReportBloc, FieldReportState>(
                  builder: (context, state) {
                    if (state is FieldReportLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: FieldReportListLoading(),
                      );
                    }

                    if (state is FieldReportEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: GroupedListView<FieldReport, String>(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        elements: _fieldReports,
                        order: GroupedListOrder.DESC,
                        groupBy: (FieldReport fr) {
                          return fr.createdAt.split('T')[0];
                        },
                        groupSeparatorBuilder: (String date) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              date,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff707070),
                              ),
                            ),
                          );
                        },
                        itemBuilder: (BuildContext context, FieldReport fr) {
                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 10,
                              ),
                              leading: RoundedRectangleAvatar(
                                url: fr.author.avatar,
                              ),
                              title: Text(
                                StringUtils.capitalize(
                                  fr.title,
                                  allWords: true,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                              ),
                              subtitle: Text(
                                StringUtils.capitalize(fr.chronology),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff9d99b9),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  Routes.FIELD_REPORT_SHOW,
                                  arguments: RouteArguments(
                                    model: fr,
                                    bloc: fieldReportBloc,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => fieldReportBloc,
        child: BlocBuilder<FieldReportBloc, FieldReportState>(
          builder: (context, state) {
            if (state is! FieldReportLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.FIELD_REPORT_CREATE);
                  print('FUCKING DATA: $data');

                  if (data != null) {
                    fieldReportBloc.add(FieldReportAdded(data: data));
                  }
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    fieldReportBloc.close();
    super.dispose();
  }
}
