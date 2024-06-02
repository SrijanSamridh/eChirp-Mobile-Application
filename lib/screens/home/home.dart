import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/profile/profile.dart';
import 'package:echirp/utils/global_variables.dart';
import 'package:echirp/utils/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/provider/friend_provider.dart';
import '../../API/provider/user_provider.dart';
import '../../components/custom_clipper.dart';
import '../../components/custom_search_bar.dart';
import '../../components/headling_with_hyperlink.dart';
import 'components/event_brief_card.dart';
import 'components/mutual_friends_card.dart';
import 'components/triple_profile_pic.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserProvider _userProvider = UserProvider();

  Future<void> _initProfileData(String id) async {
    await _userProvider.fetchUserData(context, id, true);
  }

  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
    _initPotentialFriendList();
  }

  Future<void> _initPotentialFriendList() async {
    await Provider.of<FriendProvider>(context, listen: false)
        .fetchPotentialFriends(context);
    setState(() {});
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username")!;
    });
    _initProfileData(prefs.get('_id').toString());
  }

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
                  child: Image(
                    image: const AssetImage('assets/images/coverImg.png'),
                    height: size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(top: size.width * 0.04),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Row(
                            children: [
                              Text(
                                'Welcome, $username!',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ProfileScreen.routeName);
                                },
                                child: FutureBuilder(
                                  future: _userProvider.profileData,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else if (snapshot.hasData &&
                                        snapshot.data?.profilePicture != '') {
                                      final userData = snapshot.data;
                                      return CircleAvatar(
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100)),
                                            child: Image.network(
                                              "${userData?.profilePicture}",
                                              fit: BoxFit.fitWidth,
                                            )),
                                      );
                                    } else {
                                      return CircleAvatar(
                                        child: Center(
                                          child: Text(
                                            (username)
                                                .toString()
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        const CustomSearchBar(
                          // onPressed: () {},
                          searchFor: 'a friend',
                          backgroundColor: Color.fromARGB(64, 255, 255, 255),
                          fillColor: Color.fromARGB(90, 50, 50, 50),
                          iconColor: Color.fromARGB(255, 239, 239, 239),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

            // ? Events section
            HeadlineWithHyperLink(
                headingText: 'Events',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      BottomBar.routeName, arguments: 1, (route) => false);
                }),
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
                headingText: 'Friends of Friends',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      BottomBar.routeName, arguments: 2, (route) => false);
                }),
            _WidgetPotentialFriends(size: size),
            HeadlineWithHyperLink(
                headingText: "Groups",
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      BottomBar.routeName, arguments: 3, (route) => false);
                }),
            Container(
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
                      TripleProfilePic(size: size, path1: 'assets/images/goupPP.png', path2: 'assets/images/goupPP.png', path3: 'assets/images/goupPP.png',),
                      const SizedBox(width: 8.0),
                      const Text(
                        '33 mutual friends',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WidgetPotentialFriends extends StatelessWidget {
  const _WidgetPotentialFriends({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final friendProvider = Provider.of<FriendProvider>(context);
    final potentialFriends = friendProvider.potentialFriends?.potentialFriends;
    return potentialFriends == null
        ? SkeletonLoaders.buildSkeletonLoader(context)
        : SizedBox(
            height: size.height * 0.20, // Set a fixed height for the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: potentialFriends
                  .length, // Use the actual length of potentialFriends
              itemBuilder: (context, index) {
                final data = potentialFriends[index];
                return MutualFriendCard(
                  size: size,
                  profileImg: 'assets/images/dummyDP.png',
                  userName: data.friend.username,
                  mutualCount: data.count,
                  selectedColor: index == 0
                      ? GlobalVariables.colors.primaryGradient
                      : GlobalVariables.colors.unselectedCardGradient,
                  textColor: index == 0 ? Colors.white : Colors.black,
                );
              },
            ),
          );
  }
}
