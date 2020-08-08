import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/account_info/contact/contact_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/components/list_contact_data.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  ContactBloc _contactBloc;
  List<Contact> _contacts;

  @override
  void initState() {
    _contacts = List<Contact>();
    _contactBloc = ContactBloc();
    _contactBloc.add(ContactScreenInitialized());
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
              'Contacts',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _contactBloc,
              child: BlocListener<ContactBloc, ContactState>(
                listener: (context, state) {
                  if (state is ContactLoaded) {
                    setState(() {
                      _contacts = state.data;
                    });
                  }

                  if (state is ContactCreated) {
                    setState(() {
                      _contacts.insert(0, state.data);
                    });
                  }
                },
                child: BlocBuilder<ContactBloc, ContactState>(
                  builder: (context, state) {
                    if (state is ContactLoading) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(
                          title: 'Requesting Data',
                          subtitle:
                              'We\'re processing your data, please wait...',
                        ),
                      );
                    }

                    if (state is ContactEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return ListContactData(contacts: _contacts);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _contactBloc,
        child: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is! ContactLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.CONTACT_INFO_ADD);

                  if (data != null) {
                    _contactBloc.add(ContactAdded(data: data));
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
