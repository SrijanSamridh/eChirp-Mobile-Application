import 'package:echirp/API/models/friends.model.dart';
import 'package:echirp/API/models/potentialFriends.dart';
import 'package:flutter/material.dart';
import 'package:echirp/API/controller/friend.controller.dart';
import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/friends/components/customTile.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends';

  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late Future<List<Friends>?> _myFriends;
  late Future<PotentialFriends?> _potentialFriends;

  final friendFuture = FriendController();

  @override
  void initState() {
    super.initState();
    _myFriends = _initFriends();
    _initPotentialFriends();
  }

  Future<List<Friends>?> _initFriends() async {
    try {
      return friendFuture.fetchMyFriends('/friends');
    } catch (e) {
      debugPrint('Error initializing friends: $e');
      return null;
    }
  }

  Future<void> _initPotentialFriends() async {
    try {
      _potentialFriends = friendFuture.fetchPotentialFriends('/potential');
    } catch (e) {
      debugPrint('Error initializing potentialFriends: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.18),
              child: CustomAppBar(
                  size: size,
                  title: 'Find Friends',
                  showCreate: false,
                  tabs: const <Widget>[
                    Tab(
                      text: "Friends",
                    ),
                    Tab(
                      text: "Potential",
                    ),
                    Tab(
                      text: "Requests",
                    ),
                  ],
                  searchfor: 'people',
                  onPressed: () {},
                  )),
          body: TabBarView(children: <Widget>[_myFriendsList(), _potentialFriendsList(), _friendRequestsList()]),
        ));
  }

  Widget _myFriendsList() {
    return FutureBuilder<List<Friends>?>(
        future: _myFriends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final friends = snapshot.data!;
            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return
                  CustomTile(
                    title: friend.username ?? '',
                    subTitle: friend.bio ?? '',
                    image: '',
                    mutuals: friend.numberOfFriends.toString(),
                    myFriend: true,
                    id: friend.id ?? '',
                  );
              },
            );
          } else {
            return const Center(child: Text('No friends available'));
          }
        });
  }

  Widget _potentialFriendsList() {
    return FutureBuilder<PotentialFriends?>(
        future: _potentialFriends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final potentialFriends = snapshot.data!.potentialFriends;
            return ListView.builder(
              itemCount: potentialFriends.length,
              itemBuilder: (context, index) {
                final friend = potentialFriends[index];
                return CustomTile(
                  title: friend.friend.username,
                  subTitle:  '',
                  image:'' ,
                  mutuals: '',
                  myFriend: false,
                   id: friend.friend.id, // Provide image URL here if applicable
                );
              },
            );
          } else {
            return const Center(child: Text('No friends available'));
          }
        });
  }
  Widget _friendRequestsList() {
    return FutureBuilder<PotentialFriends?>(
        future: _potentialFriends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final potentialFriends = snapshot.data!.potentialFriends;
            return ListView.builder(
              itemCount: potentialFriends.length,
              itemBuilder: (context, index) {
                final friend = potentialFriends[index];
                return CustomTile(
                  title: friend.friend.username,
                  subTitle:  '',
                  image:'' ,
                  mutuals: '',
                  myFriend: false,
                   id: friend.friend.id, // Provide image URL here if applicable
                );
              },
            );
          } else {
            return const Center(child: Text('No Request available'));
          }
        });
  }
}

