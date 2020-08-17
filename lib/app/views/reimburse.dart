import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/reimburse/reimburse_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/widgets/reimburse/reimburse_list.dart';
import 'package:flutter_prismahr/app/views/widgets/reimburse/reimburse_list_loading.dart';

class ReimburseScreen extends StatefulWidget {
  ReimburseScreen({Key key}) : super(key: key);

  @override
  _ReimburseScreenState createState() => _ReimburseScreenState();
}

class _ReimburseScreenState extends State<ReimburseScreen> {
  ReimburseBloc _reimburseBloc;
  List<Reimburse> _reimburses;

  @override
  void initState() {
    _reimburses = <Reimburse>[];
    _reimburseBloc = ReimburseBloc();
    _reimburseBloc.add(ReimburseScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    _reimburseBloc.close();
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
            title: Text('Reimburse Requests'),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _reimburseBloc,
              child: BlocListener<ReimburseBloc, ReimburseState>(
                listener: (context, state) {
                  if (state is ReimburseLoaded) {
                    _reimburses = state.data;
                  }

                  if (state is ReimburseCreated) {
                    setState(() {
                      _reimburses.add(state.data);
                    });
                  }
                },
                child: BlocBuilder<ReimburseBloc, ReimburseState>(
                  builder: (context, state) {
                    if (state is! ReimburseLoading) {
                      return ReimburseList(data: _reimburses);
                    }

                    if (state is ReimburseEmpty) {
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
                      child: ReimburseListLoading(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _reimburseBloc,
        child: BlocBuilder<ReimburseBloc, ReimburseState>(
          builder: (context, state) {
            if (state is! ReimburseLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.REIMBURSE_CREATE);

                  if (data != null) {
                    _reimburseBloc.add(ReimburseAdded(data: data));
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
