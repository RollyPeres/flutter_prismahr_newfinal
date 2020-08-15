import 'dart:ui';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/field_report/field_report_bloc.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/app/components/interactive_gallery.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:intl/intl.dart';

class FieldReportShowScreen extends StatelessWidget {
  final FieldReportBloc fieldReportBloc;
  final FieldReport fieldReport;

  const FieldReportShowScreen({
    Key key,
    @required this.fieldReportBloc,
    @required this.fieldReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => this.fieldReportBloc,
          child: BlocListener<FieldReportBloc, FieldReportState>(
            listener: (_, state) {
              if (state is FieldReportDeleted) {
                Navigator.of(context).pop();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPersonInChargeIndicator(context),
                _buildTitleAndChronology(context),
                _buildReportAuthorInformation(context),
                _buildScrollableImageAttachments(context),
                _buildComments(context),
              ],
            ),
          ),
        ),
      ),
      endDrawer: _buildDrawer(context),
    );
  }

  Widget _buildPersonInChargeIndicator(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child: Text(
            'Persons in charge',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: fieldReport.participants.map((p) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RoundedRectangleAvatar(
                  url: p.avatar,
                  height: 41,
                  width: 41,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndChronology(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Text(
            StringUtils.capitalize(
              fieldReport.title,
              allWords: true,
            ),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Text(
            StringUtils.capitalize(fieldReport.chronology),
          ),
        ),
      ],
    );
  }

  Widget _buildReportAuthorInformation(BuildContext context) {
    final DateTime createdAt = DateTime.parse(fieldReport.createdAt);
    final String dateCreatedAt = DateFormat.yMMMMEEEEd().format(createdAt);
    final String timeCreatedAt = DateFormat.Hms().format(createdAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Text(
            'Reported by',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Row(
            children: [
              RoundedRectangleAvatar(
                url: fieldReport.author.avatar,
                height: 40,
                width: 40,
                borderRadius: BorderRadius.circular(100),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fieldReport.author.name,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '$dateCreatedAt at $timeCreatedAt',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff9d99b9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableImageAttachments(BuildContext context) {
    return InteractiveGallery(images: fieldReport.images);
  }

  Widget _buildComments(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('Comments',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w900)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: RoundedRectangleAvatar(height: 41, width: 41),
              ),
              Flexible(
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Form(
                      child: FormInput(
                        maxLines: 3,
                        hintText: 'Write your comment...',
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 10,
                      child: FloatingActionButton(
                        child: Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Report',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800)),
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.FIELD_REPORT_UPDATE,
                  arguments: fieldReport,
                );
              },
            ),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Assign Participant',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800)),
              onTap: () {},
            ),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.volume_off),
              title: Text('Mute This Report',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800)),
              onTap: () {},
            ),
            Divider(height: 0),
            Spacer(),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Mark As Solved',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w800)),
              onTap: () {},
            ),
            Divider(height: 0),
            ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red),
              title: Text(
                'Delete This Report',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      'Delete This Report?',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                    ),
                    titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: Text(
                            'This action will delete your report permanently. '
                            'If you wish to keep it and prevent participants '
                            'from commenting, you might want to close '
                            'the report instead of deleting it.',
                          ),
                        ),
                        Divider(height: 0),
                        SizedBox(
                          width: double.infinity,
                          height: 57,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            title: Text(
                              'Understood, delete this report',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.redAccent,
                                  ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              fieldReportBloc
                                ..add(DeleteModalConfirmed(
                                  id: this.fieldReport.id,
                                ));
                            },
                          ),
                        ),
                      ],
                    ),
                    contentTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14),
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
