import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

import '../../components/custom_clipper.dart';
import '../../components/custom_search_bar.dart';
import '../../components/headling_with_hyperlink.dart';
import 'components/event_brief_card.dart';
import 'components/mutual_friends_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              // ? Header section
              ClipPath(
                clipper: MyCustomClipper(),
                child: const Image(
                  image: AssetImage('assets/images/coverImg.png'),
                ),
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Row(
                          children: [
                            const Text(
                              'Welcome, Alison!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  child: Image.asset(
                                    'assets/images/dummyDP.png',
                                    fit: BoxFit.fitWidth,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      CustomSearchBar(
                        onPressed: () {},
                        searchFor: 'events',
                        backgroundColor:
                            const Color.fromARGB(64, 255, 255, 255),
                        fillColor: const Color.fromARGB(90, 50, 50, 50),
                        iconColor: const Color.fromARGB(255, 239, 239, 239),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          // ? Events section
          HeadlineWithHyperLink(headingText: 'Events', onPressed: () {}),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                EventBriefCard(
                  size: size,
                  imageUrl: 'assets/images/dummy_event.png',
                  profileImg: 'assets/images/dummyDP.png',
                  userName: "By Meg Rigden",
                  dateTime: '23 Dec at 10:00 am',
                  location: 'Mumbai, Maharshtra , India',
                ),
                EventBriefCard(
                  size: size,
                  imageUrl: 'assets/images/dummy_image.jpg',
                  profileImg: 'assets/images/dummyDP.png',
                  userName: "By Meg Rigden",
                  dateTime: '23 Dec at 10:00 am',
                  location: 'Mumbai, Maharshtra , India',
                ),
                EventBriefCard(
                  size: size,
                  imageUrl: 'assets/images/dummy_event.png',
                  profileImg: 'assets/images/dummyDP.png',
                  userName: "By Meg Rigden",
                  dateTime: '23 Dec at 10:00 am',
                  location: 'Mumbai, Maharshtra , India',
                ),
              ],
            ),
          ),

          // ? Mutual Friends section
          HeadlineWithHyperLink(
              headingText: 'Mutual Friends', onPressed: () {}),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MutualFriendCard(
                  size: size,
                  profileImg: 'assets/images/dummyDP.png',
                  userName: 'Meg Rigden',
                  mutualCount: 1,
                  selectedColor: GlobalVariables.kPrimaryGradientColor,
                  textColor: Colors.white,
                ),
                MutualFriendCard(
                  size: size,
                  profileImg: 'assets/images/dummyDP.png',
                  userName: 'Meg Rigden',
                  mutualCount: 1,
                  selectedColor: GlobalVariables.kUnselectedCardGradientColor,
                  textColor: Colors.black,
                ),
                MutualFriendCard(
                  size: size,
                  profileImg: 'assets/images/dummyDP.png',
                  userName: 'Meg Rigden',
                  mutualCount: 1,
                  selectedColor: GlobalVariables.kUnselectedCardGradientColor,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
          HeadlineWithHyperLink(headingText: "Groups", onPressed: () {}),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: EdgeInsets.all(size.height * 0.02),
            height: size.height * 0.28,
            width: size.width,
            decoration: BoxDecoration(
                gradient: GlobalVariables.kPrimaryGradientColor,
                borderRadius: BorderRadius.circular(30.0)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        child: Image(
                            image: AssetImage('assets/images/goupPP.png')),
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
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.18),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.1),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.02),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        '33 mutual friends',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ]),
          )
        ],
      ),
    ));
  }
}
