import 'package:flutter/material.dart';
import 'package:echirp/API/controller/event.controller.dart';
import 'package:echirp/screens/events/create_event.dart';
import '../../API/models/event.models.dart';
import '../../components/custom_app_bar.dart';
import 'components/join_section_card.dart';
import 'components/join_via_link.dart';
import 'components/my_event_card.dart';

class EventsScreen extends StatefulWidget {
  static const String routeName = '/events';

  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late Future<Events?> _myEvents;
  late Future<Events?> _allEvents;
  late Future<Events?> _upcomingEvents;
  final eventsFuture = EventController();

  @override
  void initState() {
    super.initState();
    _initEvents();
  }

  Future<void> _initEvents() async {
    try {
      _allEvents = eventsFuture.fetchEvents('/');
      _myEvents = eventsFuture.fetchEvents('/created');
      _upcomingEvents = eventsFuture.fetchEvents('/upcoming');
    } catch (e) {
      debugPrint('Error initializing events: $e');
    }
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
            JoinViaLink(size: size, eventController: eventsFuture,),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinSection(Size size) {
    return FutureBuilder<Events?>(
      future: _allEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data!.events;
          return ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              final event = events?[index];
              return JoinSectionCard(
                size: size,
                imgUrl: 'assets/images/dummy_event.png',
                profileImg: 'assets/images/dummyDP.png',
                username: event?.createdBy ?? 'By Unknown User',
                typeOfEvent: event?.eventMode ?? 'Unknown Event Type',
                date: event?.dateOfEvent,
                time: event?.startTime ?? 'Unknown Time',
                location: event?.location ?? 'Unknown Location',
                onPressed: () {},
              );
            },
          );
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }

  Widget _buildMyEvents(Size size) {
    return FutureBuilder<Events?>(
      future: _myEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data!.events;
          return ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              final event = events?[index];
              return MyEventCard(
                size: size,
                imgUrl: 'assets/images/dummy_event.png',
                date: event?.dateOfEvent.toString() ??'23 Dec 2023',
                time: event?.startTime ??'10:00 am',
                typeOfEvent: event?.subCategory ?? 'Poetry Event',
                location: event?.location ??'Mumbai, Maharashtra, India',
                about: event?.eventDescription ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                visibility: event?.eventMode ?? 'Public',
                guest: event?.participants?.length ??100,
              );
            },
          );
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }

  Widget _buildUpcomingEvents(Size size) {
    return FutureBuilder<Events?>(
      future: _upcomingEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data!.events;
          return ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              final event = events?[index];
              return MyEventCard(
                size: size,
                imgUrl: 'assets/images/dummy_event.png',
                date: event?.dateOfEvent.toString() ??'23 Dec 2023',
                time: event?.startTime ??'10:00 am',
                typeOfEvent: event?.subCategory ?? 'Poetry Event',
                location: event?.location ??'Mumbai, Maharashtra, India',
                about: event?.eventDescription ??
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                visibility: event?.eventMode ?? 'Public',
                guest: event?.participants?.length ??100,
              );
            },
          );
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }
}
