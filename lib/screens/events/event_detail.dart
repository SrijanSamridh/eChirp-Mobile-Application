import 'package:echirp/API/models/event.models.dart';
import 'package:echirp/API/provider/event_provider.dart';
import 'package:echirp/utils/data_formatter.dart';
import 'package:echirp/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/components/triple_profile_pic.dart';

class EventDetail extends StatelessWidget {
  static const String routeName = '/event-detail';

  int index;

  EventDetail({
    Key? key,
    required this.index,
  }) : super(key: key);

  bool isLoggedUser = true;

  @override
  Widget build(BuildContext context) {
    final event =
        Provider.of<EventsProvider>(context, listen: false).allEvents?.events;
    debugPrint(event?[index].dateOfEvent.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Image.asset('assets/images/eventBackground.png'),
          // Content Container
          Positioned(
            top: size.height * 0.3,
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(children: [
              Container(
                //padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
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
                      Colors.black54,
                      // Colors.black45,
                      Colors.transparent // Transparent color at the top
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Orange Container
                    buildInfoCard(size, event),
                    // IntroInfoCard(size: size),

                    const SizedBox(height: 20),
                    // Row of RRECT Images
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Images(size, event?[index].img1Url ?? ''),
                          Images(size, event?[index].img2Url ?? ''),
                          Images(size, event?[index].img3Url ?? ''),
                          Images(size, event?[index].img4Url ?? ''),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // Tile with Leading Avatar, Title, Subtitle, and Trailing Join Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/dummyDP.png'),
                        ),
                        title: const Text(
                          'Created by:',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        subtitle: isLoggedUser
                            ? const Text(
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
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text('Friends',
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
                              gradient: GlobalVariables.colors.primaryGradient,
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
                                  child: const Text(
                                    'Cancel Event',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {},
                                  child: const Text(
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: size.height * 0.1,
                  alignment: Alignment.bottomCenter,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.75,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: event?[index].eventTitle,
                                        style: TextStyle(
                                            fontSize: size.height * 0.022,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: "   ${event?[index].eventMode!}",
                                      style: TextStyle(
                                          fontSize: size.height * 0.015,
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
                                fontSize: size.height * 0.022,
                              ),
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
                                fontSize: size.height * 0.032,
                              ),
                            ),
                            Text(
                              "Guests",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: size.height * 0.015,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Padding buildInfoCard(Size size, List<Event>? event) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.12,
        left: size.width * 0.01,
        right: size.width * 0.01,
      ),
      child: Container(
        height: size.height * 0.35,
        decoration: BoxDecoration(
          gradient: GlobalVariables.colors.primaryGradient,
          borderRadius: BorderRadius.circular(35),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/goupPP.png',
                      fit: BoxFit.fill,
                    ),
                    // Image.network(
                    //   event?[index].coverImgUrl ??
                    //       'assets/images/goupPP.png',
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: size.height * 0.132,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DataFormatter.formatDate(
                            event?[index].dateOfEvent.toString() ?? '')
                        // "${event?[index].dateOfEvent.toString() ??'date'}"
                        ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${event?[index].startTime} to ${event?[index].endTime}",
                        style: TextStyle(
                            fontSize: size.height * 0.015,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: Expanded(
                              child: Text(
                                "${event?[index].location}, ${event?[index].address}",
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: size.height * 0.015,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Description
            Expanded(
              child: Text(
                event?[index].eventDescription ?? "No description available",
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // const SizedBox(height: 10),
            // Number of Mutual Friends
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.width,
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '33 Mutual Friends attending',
                    // event?[index].,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                TripleProfilePic(
                  size: size,
                  path2: 'assets/images/goupPP.png',
                  path3: 'assets/images/goupPP.png',
                  path1: 'assets/images/goupPP.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IntroInfoCard extends StatelessWidget {
  const IntroInfoCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(size.height * 0.02),
      height: size.height * 0.28,
      width: size.width,
      decoration: BoxDecoration(
          gradient: GlobalVariables.colors.primaryGradient,
          borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Image(image: AssetImage('assets/images/goupPP.png')),
              ),
              const SizedBox(width: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Mumbai Events",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.018),
                  ),
                  Text(
                    "23.1k members",
                    style: TextStyle(
                        color: const Color.fromARGB(205, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.015),
                  ),
                ],
              ),
            ],
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TripleProfilePic(
                size: size,
                path1: 'assets/images/goupPP.png',
                path2: 'assets/images/goupPP.png',
                path3: 'assets/images/goupPP.png',
              ),
              const SizedBox(width: 8.0),
              const Text(
                '33 mutual friends',
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget Images(Size size, String url) {
  return Container(
    height: size.height * 0.08,
    width: 90,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
    title: const Text(
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
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
          const SizedBox(width: 16), // Add space between buttons
          Container(
            width: 110,
            height: 40,
            decoration: BoxDecoration(
                gradient: GlobalVariables.colors.primaryGradient,
                borderRadius: BorderRadius.circular(30)),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
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
