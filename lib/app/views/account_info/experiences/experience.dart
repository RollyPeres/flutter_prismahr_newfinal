import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/experience/experience_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/components/list_experience_data.dart';

class ExperienceScreen extends StatefulWidget {
  ExperienceScreen({Key key}) : super(key: key);

  @override
  _ExperienceScreenState createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  ExperienceBloc _experienceBloc;
  List<Experience> _experiences;

  @override
  void initState() {
    _experiences = List<Experience>();
    _experienceBloc = ExperienceBloc();
    _experienceBloc.add(ExperienceScreenInitialized());
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
              'Experiences',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _experienceBloc,
              child: BlocListener<ExperienceBloc, ExperienceState>(
                listener: (context, state) {
                  if (state is ExperienceLoaded) {
                    setState(() {
                      _experiences = state.data;
                    });
                  }

                  if (state is ExperienceCreated) {
                    setState(() {
                      _experiences.insert(0, state.data);
                    });
                  }
                },
                child: BlocBuilder<ExperienceBloc, ExperienceState>(
                  builder: (context, state) {
                    if (state is ExperienceLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(
                          title: 'Requesting Data',
                          subtitle:
                              'We\'re processing your data, please wait...',
                        ),
                      );
                    }

                    if (state is ExperienceEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return ListExperienceData(experiences: _experiences);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _experienceBloc,
        child: BlocBuilder<ExperienceBloc, ExperienceState>(
          builder: (context, state) {
            if (state is ExperienceLoaded || state is ExperienceEmpty) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.EXPERIENCE_INFO_ADD);

                  if (data != null) {
                    _experienceBloc.add(ExperienceAdded(data: data));
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
