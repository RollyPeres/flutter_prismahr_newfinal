import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave/leave_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave_update/leave_update_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';

import 'components/leave_list.dart';
import 'components/leave_list_loading.dart';

class LeaveScreen extends StatefulWidget {
  LeaveScreen({Key key}) : super(key: key);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  LeaveBloc _leaveBloc;
  LeaveUpdateBloc _leaveUpdateBloc;
  List<Leave> _leaves;

  @override
  void initState() {
    print('INIT STATE CALLED');
    _leaves = <Leave>[];
    // FIXME: The event does not get called
    _leaveBloc = BlocProvider.of<LeaveBloc>(context);
    _leaveUpdateBloc = BlocProvider.of<LeaveUpdateBloc>(context);
    _leaveBloc.add(LeaveScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    print('DISPOSE CALLED');
    _leaveBloc.close();
    _leaveUpdateBloc.close();
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
            child: MultiBlocListener(
              listeners: [
                BlocListener<LeaveBloc, LeaveState>(
                  listener: (context, state) {
                    if (state is LeaveLoaded) {
                      setState(() {
                        _leaves = state.data;
                      });
                    }

                    if (state is LeaveCreated) {
                      setState(() {
                        _leaves.add(state.data);
                      });
                    }
                  },
                ),
                BlocListener<LeaveUpdateBloc, LeaveUpdateState>(
                  listener: (context, state) {
                    if (state is LeaveUpdateSuccess) {
                      int index = _leaves.indexWhere((leave) {
                        return leave.id == state.data.id;
                      });

                      setState(() {
                        _leaves[index] = state.data;
                        _leaveUpdateBloc.add(ResetState());
                      });
                    }
                  },
                ),
              ],
              child: BlocBuilder<LeaveBloc, LeaveState>(
                builder: (context, state) {
                  if (state is LeaveLoading) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: LeaveListLoading(),
                    );
                  }

                  if (state is LeaveEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Empty(),
                    );
                  }

                  return LeaveList(data: _leaves);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<LeaveBloc, LeaveState>(
        builder: (context, state) {
          if (state is! LeaveLoading) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                _leaveBloc.add(LeaveScreenInitialized());
                print(await _leaveBloc.length);

                // final data = await Navigator.of(context).pushNamed(
                //   Routes.LEAVE_CREATE,
                // );

                // if (data != null) {
                //   _leaveBloc.add(LeaveAdded(data: data));
                // }
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
