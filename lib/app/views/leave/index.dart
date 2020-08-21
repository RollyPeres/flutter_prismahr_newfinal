import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave/leave_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';

import 'components/leave_list.dart';
import 'components/leave_list_loading.dart';

class LeaveScreen extends StatefulWidget {
  LeaveScreen({Key key}) : super(key: key);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  LeaveBloc _leaveBloc;
  List<Leave> _leaves;

  @override
  void initState() {
    _leaves = <Leave>[];
    _leaveBloc = LeaveBloc();
    _leaveBloc.add(LeaveScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    _leaveBloc.close();
    super.dispose();
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
              'Leave Requests',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _leaveBloc,
              child: BlocListener<LeaveBloc, LeaveState>(
                listener: (context, state) {
                  if (state is LeaveLoaded) {
                    _leaves = state.data;
                  }

                  if (state is LeaveCreated) {
                    setState(() {
                      _leaves.add(state.data);
                    });
                  }
                },
                child: BlocBuilder<LeaveBloc, LeaveState>(
                  builder: (context, state) {
                    if (state is! LeaveLoading) {
                      return LeaveList(data: _leaves);
                    }

                    if (state is LeaveEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: LeaveListLoading(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _leaveBloc,
        child: BlocBuilder<LeaveBloc, LeaveState>(
          builder: (context, state) {
            if (state is! LeaveLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.LEAVE_CREATE);

                  if (data != null) {
                    _leaveBloc.add(LeaveAdded(data: data));
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
}
