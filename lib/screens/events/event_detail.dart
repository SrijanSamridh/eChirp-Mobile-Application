import 'package:echirp/API/provider/event_provider.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../API/provider/friend_provider.dart';

class EventDetail extends StatelessWidget {
  static const String routeName = '/event-detail';

  int index;
  bool isLoggedUser = true;

  EventDetail({
    Key? key,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final event =
        Provider.of<EventsProvider>(context, listen: false).allEvents?.events;
    print(event?[index].dateOfEvent);
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/eventBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content Container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(children: [
              Container(
                //padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // color: Colors.black,

                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black, // Black color at the bottom
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.transparent // Transparent color at the top
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Orange Container
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: GlobalVariables.kPrimaryGradientColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 110,
                                  width: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                        event?[index].coverImgUrl ??
                                            'assets/images/dummyDP.png',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatDate(event?[index]
                                              .dateOfEvent
                                              .toString() ??
                                          '')
                                      // "${event?[index].dateOfEvent.toString() ??'date'}"

                                      ,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${event?[index].startTime} to ${event?[index].endTime}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_pin,
                                          color: Colors.white,
                                        ),
                                        Container(
                                          width: mq.width * 0.5,
                                          child: Text(
                                            "${event?[index].location}, ${event?[index].address}",
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Description
                            Text(
                              event?[index].eventDescription ??
                                  "No description available",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Number of Mutual Friends
                            Container(
                              width: mq.width,
                              alignment: Alignment.centerRight,
                              child: Text(
                                '33 Mutual Friends attending',
                                // event?[index].,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    // Row of RRECT Images
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Images(event?[index].img1Url ?? ''),
                          Images(event?[index].img2Url ?? ''),
                          Images(event?[index].img3Url ?? ''),
                          Images(event?[index].img4Url ?? ''),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Tile with Leading Avatar, Title, Subtitle, and Trailing Join Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/dummyDP.png'),
                        ),
                        title: Text(
                          'Created by:',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        subtitle: isLoggedUser
                            ? Text(
                                "You",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    event?[index].createdBy?.username ?? '',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('Friends',
                                      style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                        trailing: Container(
                          width: 110,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: GlobalVariables.kPrimaryGradientColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: isLoggedUser
                              ? TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(context);
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Cancel Event',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Joined',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: mq.height * 0.1,
                alignment: Alignment.bottomCenter,
                //color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mq.width * 0.6,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: event?[index].eventTitle,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "   ${event?[index].eventMode!}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "At ${event?[index].location ?? ''}",
                            style: TextStyle(
                                color: Colors.white,
                                //fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            event?[index].maxParticipants.toString() ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                          Text(
                            "Guests",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// Function to convert date string to day-month-year format
String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  final List<String> months = [
    '', // Leave an empty string at index 0 to match month numbers with indices
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December'
  ];
  return '${date.day} ${months[date.month]} ${date.year}';
}

Widget Images(String url) {
  return Container(
    color: Colors.white10,
    height: 80,
    width: 90,
    child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url,
          fit: BoxFit.fill,
        )),
  );
}

Widget CustomDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    title: Text(
      'Do you want to cancel the event?',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center actions horizontally
        children: <Widget>[
          Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.orange)),
            child: TextButton(
              onPressed: () {
                // Action when No button is pressed
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          SizedBox(width: 16), // Add space between buttons
          Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(
                gradient: GlobalVariables.kPrimaryGradientColor,
                borderRadius: BorderRadius.circular(30)),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
