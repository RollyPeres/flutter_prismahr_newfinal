import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/event/event_bloc.dart';
import 'package:flutter_prismahr/app/components/empty.dart';
import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';

import 'components/event_list.dart';
import 'components/event_list_loading.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventBloc _eventBloc;
  List<Event> _events;

  @override
  void initState() {
    _events = <Event>[];
    _eventBloc = EventBloc();
    _eventBloc.add(EventScreenInitialized());
    super.initState();
  }

  @override
  void dispose() {
    _eventBloc.close();
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
              'Event Requests',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) => _eventBloc,
              child: BlocListener<EventBloc, EventState>(
                listener: (context, state) {
                  if (state is EventLoaded) {
                    _events = state.data;
                  }

                  if (state is EventCreated) {
                    setState(() {
                      _events.add(state.data);
                    });
                  }
                },
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: EventListLoading(),
                      );
                    }

                    if (state is EventEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Empty(),
                      );
                    }

                    return EventList(data: _events);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocProvider(
        create: (context) => _eventBloc,
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is! EventLoading) {
              return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final data = await Navigator.of(context)
                      .pushNamed(Routes.EVENT_CREATE);

                  if (data != null) {
                    _eventBloc.add(EventAdded(data: data));
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
