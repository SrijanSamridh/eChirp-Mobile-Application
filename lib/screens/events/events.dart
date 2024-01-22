import 'package:echirp/screens/events/create_event.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import 'components/join_section_card.dart';
import 'components/join_via_link.dart';
import 'components/my_event_card.dart';

class EventsScreen extends StatefulWidget {
  static const String routeName = '/events';
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
            ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return JoinSectionCard(
                  size: size,
                  imgUrl: 'assets/images/dummy_event.png',
                  profileImg: 'assets/images/dummyDP.png',
                  username: 'By Meg Rigden',
                  typeOfEvent: 'Social event type',
                  date: '23 Dec 2023',
                  time: '10:00 am',
                  location: 'Mumbai, India',
                  onPressed: () {},
                );
              },
            ),
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return MyEventCard(
                  size: size,
                  imgUrl: 'assets/images/dummy_event.png',
                  date: '23 Dec 2023',
                  time: '10:00 am',
                  typeOfEvent: 'Poetry Event',
                  location: 'Mumbai, Maharshtra , India ',
                  about: 'Lorem ipsum dolor sit amet, conct adipiscing elit.',
                  visibility: 'Public',
                  guest: 100,
                );
              },
            ),
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return MyEventCard(
                  size: size,
                  imgUrl: 'assets/images/dummy_event.png',
                  date: '23 Dec 2023',
                  time: '10:00 am',
                  typeOfEvent: 'Poetry Event',
                  location: 'Mumbai, Maharshtra , India ',
                  about: 'Lorem ipsum dolor sit amet, conct adipiscing elit.',
                  visibility: 'Public',
                  guest: 100,
                );
              },
            ),
            JoinViaLink(size: size, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
