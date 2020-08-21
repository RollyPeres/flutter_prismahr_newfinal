import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/personal/personal_bloc.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/personal_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/personal_repository.dart';
import 'package:flutter_prismahr/app/routes/route_arguments.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/components/list_personal_data.dart';
import 'package:flutter_prismahr/utils/request.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  PersonalBloc _personalBloc;
  PersonalModel _personalData;

  @override
  void initState() {
    super.initState();
    _personalData = PersonalModel();
    _personalBloc = PersonalBloc(
        repository: PersonalRepository(
            provider: PersonalProvider(httpClient: Request.dio)));
    _personalBloc.add(PersonalScreenInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Personal Info'),
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: BlocProvider(
                create: (context) => _personalBloc,
                child: BlocListener<PersonalBloc, PersonalState>(
                  listener: (context, state) {
                    if (state is PersonalLoaded) {
                      setState(() {
                        _personalData = state.data;
                      });
                    }
                  },
                  child: BlocBuilder<PersonalBloc, PersonalState>(
                    builder: (context, state) {
                      return ListPersonalData(data: _personalData);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _personalBloc,
        child: BlocBuilder<PersonalBloc, PersonalState>(
          builder: (context, state) {
            if (state is PersonalLoaded) {
              return FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () async {
                  final data = await Navigator.of(context).pushNamed(
                    Routes.ACCOUNT_INFO_PERSONAL_EDIT,
                    arguments: RouteArguments(model: state.data),
                  );

                  if (data != null) {
                    _personalBloc.add(PersonalDataUpdated(data: data));
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
    _personalBloc.close();
    super.dispose();
  }
}
