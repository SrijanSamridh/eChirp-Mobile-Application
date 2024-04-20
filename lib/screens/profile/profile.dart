import 'package:dotted_line/dotted_line.dart';
import 'package:echirp/screens/home/components/event_brief_card.dart';
import 'package:echirp/screens/profile/components/createdEventTile.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../API/models/event.models.dart';
import '../../API/models/userData.model.dart';
import '../../API/provider/friend_provider.dart';
import '../../API/provider/user_provider.dart';
import 'settings/profile_settings.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  final String id;
  final bool loggedUser;

  const ProfileScreen({super.key, this.loggedUser = true, this.id = ''});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _initProfileData();
  }

  Future<void> _initProfileData() async {
    await _userProvider.fetchUserData(widget.id, widget.loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set background color to transparent
        actions: [
          widget.loggedUser
              ? IconButton(
                  icon: const Icon(
                      Icons.settings), // Use IconButton for interaction
                  onPressed: () async {
                    Navigator.pushNamed(
                      // ignore: use_build_context_synchronously
                      context,
                      ProfileSettings.routeName,
                      arguments: widget.id,
                    );
                  },
                )
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserData?>(
          future: _userProvider.profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final userData = snapshot.data;
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
                          child: userData?.profilePicture == ''
                              ? Center(
                                  child: Text(
                                    (userData?.firstName)
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:
                                      Image.network(userData!.profilePicture!)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData?.firstName == ''
                                  ? (userData?.username).toString()
                                  : "${userData?.firstName} ${userData?.lastName}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const Text('Artist')
                          ],
                        ),
                        const SizedBox(height: 5),
                        widget.loggedUser
                            ? Container()
                            : Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient:
                                        GlobalVariables.kPrimaryGradientColor),
                                child: TextButton(
                                  onPressed: () {
                                    Provider.of<FriendProvider>(context,
                                          listen: false)
                                      .sendFriendRequest(context, widget.id);
                                  },
                                  child: const Text(
                                    'Add Friend',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        (userData?.bio).toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 85,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (userData?.myCreatedEvents.length)
                                      .toString(), // Replace with actual number of events created
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Events Created',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const DottedLine(
                              direction: Axis.vertical,
                              dashColor: Colors.white,
                              lineThickness: 1.5,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (userData?.numberOfFriends)
                                      .toString(), // Replace with actual number of events created
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
                                  'Friends',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const DottedLine(
                              direction: Axis.vertical,
                              dashColor: Colors.white,
                              lineThickness: 1.5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (userData?.eventsAttended.length)
                                      .toString(), // Replace with actual number of events created
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const Text(
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
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'My Created Events',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 250, child: _buildEventsCreated(size)),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Events Attended',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 200, child: _buildEventsAttended(size)),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildEventsAttended(Size size) {
    return FutureBuilder<Events?>(
      future: _userProvider.eventsAttended,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data?.events;
          if (events == null || events.isEmpty) {
            return const Center(child: Text('No events available'));
          }
          return events.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.events?.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventBriefCard(
                      size: size,
                      imageUrl: 'assets/images/dummy_event.png',
                      profileImg: 'assets/images/dummyDP.png',
                      userName: "By Meg Rigden",
                      dateTime:
                          "${formatDate(event.dateOfEvent.toString(), false)} at ${formatTime(event.startTime.toString())}",
                      location: '${event.location}, ${event.address}',
                    );
                  },
                )
              : const Center(child: Text('No events available'));
        } else {
          return const Center(child: Text('No events available'));
        }
      },
    );
  }

  Widget _buildEventsCreated(Size size) {
    return FutureBuilder<Events?>(
      future: _userProvider.eventsCreated,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final events = snapshot.data?.events;
          return ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              final event = events?[index];
              return EventTile(
                category: (event?.mainCategory).toString(),
                title: (event?.eventDescription).toString(),
                date: formatDate((event?.dateOfEvent).toString(), true),
                time: formatTime((event?.startTime).toString()),
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
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate;

      created
          ? formattedDate = DateFormat('dd MMM yyyy').format(date)
          : formattedDate = DateFormat('dd MMM').format(date);

      return formattedDate;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  String formatTime(String timeString) {
    try {
      DateTime dateTime = DateTime.parse('2022-01-01 $timeString');
      String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      debugPrint(e.toString());
      return "${e.toString().split(" ")[4]} ${e.toString().split(" ")[5]}";
    }
  }
}
