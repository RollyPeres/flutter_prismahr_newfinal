import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/sickleave/sickleave_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/widgets/sickleave/sickleave_list.dart';
import 'package:flutter_prismahr/app/views/widgets/sickleave/sickleave_list_loading.dart';

class SickleaveScreen extends StatefulWidget {
  SickleaveScreen({Key key}) : super(key: key);

  @override
  _SickleaveScreenState createState() => _SickleaveScreenState();
}

class _SickleaveScreenState extends State<SickleaveScreen> {
  SickleaveBloc _sickleaveBloc;
  List<Sickleave> _sickleaves;

  @override
  void initState() {
    _sickleaves = <Sickleave>[];
    _sickleaveBloc = SickleaveBloc();
    _sickleaveBloc.add(SickleaveScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    _sickleaveBloc.close();
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
              'Sick Leave Requests',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _sickleaveBloc,
              child: BlocListener<SickleaveBloc, SickleaveState>(
                listener: (context, state) {
                  if (state is SickleaveLoaded) {
                    _sickleaves = state.data;
                  }

                  if (state is SickleaveCreated) {
                    setState(() {
                      _sickleaves.add(state.data);
                    });
                  }
                },
                child: BlocBuilder<SickleaveBloc, SickleaveState>(
                  builder: (context, state) {
                    if (state is! SickleaveLoading) {
                      return SickleaveList(data: _sickleaves);
                    }

                    if (state is SickleaveEmpty) {
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
                      child: SickleaveListLoading(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _sickleaveBloc,
        child: BlocBuilder<SickleaveBloc, SickleaveState>(
          builder: (context, state) {
            if (state is! SickleaveLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.SICKLEAVE_CREATE);

                  if (data != null) {
                    _sickleaveBloc.add(SickleaveAdded(data: data));
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
