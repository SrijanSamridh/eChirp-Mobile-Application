import 'package:dotted_line/dotted_line.dart';
import 'package:echirp/API/controller/event.controller.dart';
import 'package:echirp/API/controller/userData.controller.dart';
import 'package:echirp/screens/home/components/event_brief_card.dart';
import 'package:echirp/screens/profile/components/createdEventTile.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../API/models/event.models.dart';
import '../../API/models/userData.model.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Events?> _eventsAttended;
  late Future<Events?> _eventsCreated;
  late Future<UserData?> _profileData;
  final eventsFuture = EventController();
  final profileFuture = UserDataController();

  @override
  void initState() {
    super.initState();
    _initEvents();
  }

  Future<void> _initEvents() async {
    try {
      _eventsAttended = eventsFuture.fetchEvents('/attended');
      _eventsCreated = eventsFuture.fetchEvents('/created');
      _profileData = profileFuture.fetchUserData();
    } catch (e) {
      debugPrint('Error initializing events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserData?>(
          future: _profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                              gradient: GlobalVariables.kPrimaryGradientColor,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.username,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text('Artist')
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: GlobalVariables.kPrimaryGradientColor),
                          child: TextButton(
                            onPressed: () {
                              // Handle add friend action
                            },
                            child: Text(
                              'Add Friend',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        userData.bio,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 95,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData.myCreatedEvents.length.toString(), // Replace with actual number of events created
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Events Created',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            DottedLine(
                              direction: Axis.vertical,
                              dashColor: Colors.white,
                              lineThickness: 1.5,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData.numberOfFriends.toString(), // Replace with actual number of events created
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Friends',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            DottedLine(
                              direction: Axis.vertical,
                              dashColor: Colors.white,
                              lineThickness: 1.5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData.eventsAttended.length.toString(), // Replace with actual number of events created
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  'Events Attended',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'My Created Events',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: 250,
                        child: _buildEventsCreated(size)),
                    
                    Text(
                      'Events Attended',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: 200,
                        child: _buildEventsAttended(size)),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No user data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildEventsAttended(Size size) {
    return FutureBuilder<Events?>(
      future: _eventsAttended,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data!.events;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events?.length,
            itemBuilder: (context, index) {
              final event = events?[index];
              return EventBriefCard(
                size: size,
                imageUrl: 'assets/images/dummy_event.png',
                profileImg: 'assets/images/dummyDP.png',
                userName: "By Meg Rigden",
                dateTime:
                    "${formatDate(event!.dateOfEvent.toString(), false)} at ${formatTime(event.startTime.toString())}",
                location: '${event.location}, ${event.address}',
              );
            },
          );
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }

  Widget _buildEventsCreated(Size size) {
    return FutureBuilder<Events?>(
      future: _eventsCreated,
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
              return EventTile(
                category: event!.mainCategory.toString(),
                title: event!.eventDescription.toString(),
                date: formatDate(event.dateOfEvent.toString(), true),
                time: formatTime(event.startTime.toString()),
                imageUrl: 'assets/images/dummy_event.png',
              );
            },
          );
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }

  String formatDate(String dateString, bool created) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate;

    created
        ? formattedDate = DateFormat('dd MMM yyyy').format(date)
        : formattedDate = DateFormat('dd MMM').format(date);

    return formattedDate;
  }

  String formatTime(String timeString) {
    DateTime dateTime = DateTime.parse('2022-01-01 $timeString');
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }
}
