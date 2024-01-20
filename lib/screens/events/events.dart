import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/components/custom_search_bar.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

import 'components/join_via_link.dart';
import 'components/my_event_card.dart';


// todo: clearn the code 

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
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Events',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.02),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(
                                  GlobalVariables.kPrimaryColor),
                              textStyle: MaterialStatePropertyAll(
                                TextStyle(
                                    fontSize: size.height * 0.012,
                                    fontWeight: FontWeight.bold),
                              ),
                              iconSize: MaterialStateProperty.all(
                                  size.height * 0.02)),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 8.0),
                              Text('Create Event'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    CustomSearchBar(
                      onPressed: () {},
                      searchFor: 'events',
                      backgroundColor: GlobalVariables.kPrimaryColor,
                      fillColor: Colors.white,
                      iconColor: GlobalVariables.kPrimaryColor,
                      iconSize: 18,
                      textColor: Colors.black,
                      textSize: 15,
                    )
                  ],
                ),
              ),
            ),
            bottom: const TabBar(
              indicatorColor: GlobalVariables.kPrimaryColor,
              labelColor: GlobalVariables.kPrimaryColor,
              tabs: <Widget>[
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
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return Center(
                  child: Container(
                    height: size.height * 0.3,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.055,
                      vertical: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                1, 3), // changes position of shadow
                          ),
                        ]),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image(
                            image: const AssetImage(
                                'assets/images/dummy_event.png'),
                            fit: BoxFit.fitWidth,
                            height: size.height * 0.3,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: size.height * 0.13,
                            width: size.width * 3,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(208, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.03, vertical: size.height * 0.01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Image.asset(
                                            'assets/images/dummyDP.png',
                                            height: 30,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        const Text(
                                          'By Meg Rigden',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    )
                                  ]),
                                  const Row(
                                    children: [
                                      Text(
                                        'Social event type',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        children: [
                                          Text(
                                            '23 Dec at 10:00 am',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              Text(
                                                'Mumbai, India',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      CustomBtn(
                                        text: 'Join event',
                                        size: size,
                                        onPressed: () {},
                                        width: size.width * 0.025,
                                        height: size.height * 0.015,
                                        textSize: size.height * 0.015,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return MyEventCard(size: size);
              },
            ),
            ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return MyEventCard(size: size);
              },
            ),
            JoinViaLink(size: size, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
