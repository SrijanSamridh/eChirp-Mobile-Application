import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:echirp/API/controller/event.controller.dart';
import 'package:echirp/screens/events/create_event.dart';
import '../../API/provider/event_provider.dart';
import '../../components/custom_app_bar.dart';
import 'components/join_section_card.dart';
import 'components/join_via_link.dart';
import 'components/my_event_card.dart';

class EventsScreen extends StatefulWidget {
  static const String routeName = '/events';
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => EventsScreenState();
}

class EventsScreenState extends State<EventsScreen> {
  late EventsProvider _eventsProvider;

  @override
  void initState() {
    super.initState();
    _eventsProvider = Provider.of<EventsProvider>(context, listen: false);
    _eventsProvider.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: CustomAppBar(
            size: size,
            showCreate: true,
            title: 'Events',
            tabs: const <Widget>[
              Tab(
                text: "Join",
              ),
              Tab(
                text: "My Events",
              ),
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "via Link",
              ),
            ],
            searchfor: 'events',
            onPressed: () {
              Navigator.of(context).pushNamed(CreateEventScreen.routeName);
            },
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildJoinSection(size),
            _buildMyEvents(size),
            _buildUpcomingEvents(size),
            JoinViaLink(size: size, eventController: EventController()),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinSection(Size size) {
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        if (eventsProvider.allEvents == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (eventsProvider.allEvents!.events!.isEmpty) {
          return const Center(child: Text('No events available'));
        } else {
          return ListView.builder(
            itemCount: eventsProvider.allEvents!.events?.length,
            itemBuilder: (context, index) {
              final event = eventsProvider.allEvents!.events?[index];
              return JoinSectionCard(
                size: size,
                imgUrl: 'assets/images/dummy_event.png',
                profileImg: 'assets/images/dummyDP.png',
                username: event?.createdBy ?? 'By Unknown User',
                typeOfEvent: event?.eventMode ?? 'Unknown Event Type',
                date: event?.dateOfEvent,
                time: event?.startTime ?? 'Unknown Time',
                location: event?.location ?? 'Unknown Location',
                onPressed: () =>
                    _eventsProvider.joinEvent(context, event?.id ?? ""),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildMyEvents(Size size) {
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        if (eventsProvider.myEvents == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (eventsProvider.myEvents!.events!.isEmpty) {
          return const Center(child: Text('No events available'));
        } else {
          return ListView.builder(
            itemCount: eventsProvider.myEvents!.events?.length,
            itemBuilder: (context, index) {
              final event = eventsProvider.myEvents!.events?[index];
              return MyEventCard(
                size: size,
                imgUrl: index % 3 == 0
                    ? 'https://media.istockphoto.com/id/974238866/photo/audience-listens-to-the-lecturer-at-the-conference.jpg?s=612x612&w=0&k=20&c=p_BQCJWRQQtZYnQlOtZMzTjeB_csic8OofTCAKLwT0M='
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3sKxhHQxlr47NLHnZNosULQPikM25ziU0UQ&s",
                date: event?.dateOfEvent?.toString() ?? '23 Dec 2023',
                time: event?.startTime ?? '10:00 am',
                typeOfEvent: event?.subCategory ?? 'Poetry Event',
                location: event?.location ?? 'Mumbai, Maharashtra, India',
                about: event?.eventDescription ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                visibility: event?.eventMode ?? 'Public',
                guest: event?.participants?.length ?? 100,
              );
            },
          );
        }
      },
    );
  }

  Widget _buildUpcomingEvents(Size size) {
    return Consumer<EventsProvider>(
      builder: (context, eventsProvider, child) {
        if (eventsProvider.upcomingEvents == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (eventsProvider.upcomingEvents!.events!.isEmpty) {
          return const Center(child: Text('No events available'));
        } else {
          return ListView.builder(
            itemCount: eventsProvider.upcomingEvents!.events?.length,
            itemBuilder: (context, index) {
              final event = eventsProvider.upcomingEvents!.events?[index];
              return MyEventCard(
                size: size,
                imgUrl: index % 3 == 0
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7eOdNf1G2L2Vq0-nOe5WO895a_74WPa6deQ&s'
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYix8GPPtyZMoceX0KmOkytUK4PGvKddwLPg&s",
                date: event?.dateOfEvent?.toString() ?? '23 Dec 2023',
                time: event?.startTime ?? '10:00 am',
                typeOfEvent: event?.subCategory ?? 'Poetry Event',
                location: event?.location ?? 'Mumbai, Maharashtra, India',
                about: event?.eventDescription ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                visibility: event?.eventMode ?? 'Public',
                guest: event?.participants?.length ?? 100,
              );
            },
          );
        }
      },
    );
  }
}
