import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_prismahr/app/bloc/leave_update/leave_update_bloc.dart';
import 'package:flutter_prismahr/app/components/badge.dart';
import 'package:flutter_prismahr/app/components/rounded_rectangle_avatar.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/routes/route_arguments.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:intl/intl.dart';

class LeaveShowScreen extends StatefulWidget {
  LeaveShowScreen({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  final Leave data;

  @override
  _LeaveShowScreenState createState() => _LeaveShowScreenState();
}

class _LeaveShowScreenState extends State<LeaveShowScreen> {
  Leave _leave;

  bool get isApproved => _leave.approvedAt != null;
  bool get isRejected => _leave.rejectedAt != null;

  @override
  void initState() {
    super.initState();
    _leave = widget.data;
  }

  void _showDeleteWarningDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Delete Request?',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w900, fontSize: 18),
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
                  'This action will abort and delete your request permanently.',
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
                    'Yes, abort and delete this request',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // fieldReportBloc
                    //   ..add(DeleteModalConfirmed(
                    //     id: this.fieldReport.id,
                    //   ));
                  },
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          contentTextStyle:
              Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime _startDate = DateFormat('yyyy-MM-dd').parse(
      _leave.startDate,
    );
    final DateTime _endDate = DateFormat('yyyy-MM-dd').parse(
      _leave.endDate,
    );

    final String _startDateMonth = DateFormat.yMMMM().format(_startDate);
    final String _endDateMonth = DateFormat.yMMMM().format(_endDate);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
          listener: (context, state) {
            if (state is LeaveUpdateSuccess) {
              setState(() {
                _leave = state.data;
              });
            }
          },
          child: BlocBuilder<LeaveUpdateBloc, LeaveUpdateState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: _buildRangePicker(_startDate, _endDate),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10.0,
                        left: 28.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$_startDateMonth',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                '/  $_endDateMonth',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    child: Text(
                      StringUtils.capitalize(_leave.reason, allWords: true),
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: _buildStatusBadge(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: Text(_leave.details),
                  ),
                  isApproved
                      ? _buildAcceptorInfo()
                      : isRejected ? _buildRejectorInfo() : SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildRangePicker(startDate, endDate) {
    return RangePicker(
      firstDate: startDate,
      lastDate: endDate,
      onChanged: (_) {},
      selectedPeriod: DatePeriod(startDate, endDate),
      datePickerLayoutSettings: DatePickerLayoutSettings(
        contentPadding: EdgeInsets.zero,
        dayPickerRowHeight: 50.0,
      ),
      datePickerStyles: DatePickerRangeStyles(
        firstDayOfWeekIndex: 1,
        displayedPeriodTitle: TextStyle(color: Colors.transparent),
        prevIcon: SizedBox(),
        nextIcon: SizedBox(),
        selectedPeriodStartDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        selectedPeriodMiddleDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(40),
        ),
        selectedPeriodLastDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    if (isApproved) {
      return Badge(
        color: Colors.green,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          'APPROVED',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 12.0, fontWeight: FontWeight.w900),
        ),
      );
    }

    if (isRejected) {
      return Badge(
        color: Colors.red,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          'REJECTED',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 12.0, fontWeight: FontWeight.w900),
        ),
      );
    }

    return Badge(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(4),
      child: Text(
        'PENDING',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontSize: 12.0, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildAcceptorInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Approved by',
            style: Theme.of(context).textTheme.caption,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: RoundedRectangleAvatar(
              height: 40,
              width: 40,
            ),
            title: Text(_leave.approver.name),
            subtitle: Text(
              DateFormat.yMMMMd().format(
                DateFormat('yyyy-MM-dd').parse(_leave.approvedAt),
              ),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRejectorInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rejected by',
            style: Theme.of(context).textTheme.caption,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: RoundedRectangleAvatar(
              height: 40,
              width: 40,
            ),
            title: Text(_leave.approver.name),
            subtitle: Text(
              DateFormat.yMMMMd().format(
                DateFormat('yyyy-MM-dd').parse(_leave.approvedAt),
              ),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    if (isApproved || isRejected) return _editingUnavailableWarning();

    return Material(
      elevation: 4.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 30.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _showDeleteWarningDialog,
            ),
            SizedBox(width: 20),
            Expanded(
              child: RaisedButton(
                child: Text('Update Request'),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Routes.LEAVE_UPDATE,
                    arguments: RouteArguments(model: _leave),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editingUnavailableWarning() {
    return Container(
      height: 66,
      child: Center(
        child: Text(
          'This request has been accepted or rejected, '
          'unable to update or delete.',
        ),
      ),
    );
  }
}
