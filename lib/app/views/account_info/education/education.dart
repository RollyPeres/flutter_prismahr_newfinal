import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/education/education_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/education_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/education_repository.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/education/components/list_education_data.dart';
import 'package:flutter_prismahr/utils/request.dart';

class EducationScreen extends StatefulWidget {
  EducationScreen({Key key}) : super(key: key);

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  EducationBloc _educationBloc;

  @override
  void initState() {
    super.initState();
    _educationBloc = EducationBloc(
        repository: EducationRepository(
            provider: EducationProvider(httpClient: Request.dio)));
    _educationBloc.add(EducationScreenInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Educations'),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _educationBloc,
              child: BlocBuilder<EducationBloc, EducationState>(
                builder: (context, state) {
                  if (state is EducationLoaded) {
                    return ListEducationData(educations: state.data);
                  }

                  if (state is EducationEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Empty(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Empty(
                      title: 'Requesting Data',
                      subtitle: 'We\'re processing your data, please wait...',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data =
              await Navigator.of(context).pushNamed(Routes.EDUCATION_INFO_ADD);

          if (data != null) {
            _educationBloc.add(EducationScreenInitialized());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _educationBloc.close();
    super.dispose();
  }
}
