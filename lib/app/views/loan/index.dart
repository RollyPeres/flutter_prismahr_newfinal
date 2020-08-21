import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/loan/loan_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';

import 'components/loan_list.dart';
import 'components/loan_list_loading.dart';

class LoanScreen extends StatefulWidget {
  LoanScreen({Key key}) : super(key: key);

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  LoanBloc _loanBloc;
  List<Loan> _loans;

  @override
  void initState() {
    _loans = <Loan>[];
    _loanBloc = LoanBloc();
    _loanBloc.add(LoanScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    _loanBloc.close();
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
            title: Text('Loan Requests'),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _loanBloc,
              child: BlocListener<LoanBloc, LoanState>(
                listener: (context, state) {
                  if (state is LoanLoaded) {
                    _loans = state.data;
                  }

                  if (state is LoanCreated) {
                    setState(() {
                      _loans.add(state.data);
                    });
                  }
                },
                child: BlocBuilder<LoanBloc, LoanState>(
                  builder: (context, state) {
                    if (state is LoanLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: LoanListLoading(),
                      );
                    }

                    if (state is LoanEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return LoanList(data: _loans);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _loanBloc,
        child: BlocBuilder<LoanBloc, LoanState>(
          builder: (context, state) {
            if (state is! LoanLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context).pushNamed(
                    Routes.LOAN_CREATE,
                  );

                  if (data != null) {
                    _loanBloc.add(LoanAdded(data: data));
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
