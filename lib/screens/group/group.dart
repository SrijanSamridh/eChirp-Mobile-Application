// ignore_for_file: avoid_print

import 'package:echirp/API/models/friends.model.dart';
import 'package:echirp/API/models/potentialFriends.dart';
import 'package:echirp/screens/group/components/groupTile.dart';
import 'package:echirp/screens/group/groupInfo.dart';
import 'package:flutter/material.dart';
import 'package:echirp/API/controller/friend.controller.dart';
import 'package:echirp/components/custom_app_bar.dart';

import '../chat/chat.dart';
import 'components/create_group.dart';

class GroupScreen extends StatefulWidget {
  static const String routeName = '/group';

  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
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
                title: 'Groups',
                showCreate: true,
                tabs: const <Widget>[
                  Tab(
                    text: "My Groups",
                  ),
                  Tab(
                    text: "Joined Groups",
                  ),
                  Tab(
                    text: "All Groups",
                  ),
                ],
                searchfor: 'Groups',
                onPressed: () {
              Navigator.of(context).pushNamed(CreateGroupScreen.routeName);
            },
                showGroup: true,
              )),
          body: TabBarView(
              children: <Widget>[_myGroupsList(), _joinedGroupsList(),
              _allGroupsList(),
              const Center(child: Text("All Groups"))]),
        ));
  }

  Widget _myGroupsList() {
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
                // ignore: unused_local_variable
                final friend = friends[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen(title: 'Poker mates',image: '',)));
                  },
                  child: const GroupTile(
                    image: 'https://blog.photofeeler.com/wp-content/uploads/2017/09/instagram-profile-picture-maker.jpg',
                      title: 'Poker Mates',
                      recentMessage: 'Are we playing today?',
                      senderName: 'John Doe',
                      totalMembers: 10,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No friends available'));
          }
        });
  }

  Widget _joinedGroupsList() {
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
                print('iddddd: ${friend.friend.id}');
                return const GroupTile(
                  image: 'https://blog.photofeeler.com/wp-content/uploads/2017/09/instagram-profile-picture-maker.jpg',
                  title: 'Poker mates',
                  recentMessage: 'Are we playing today?',
                  senderName: 'John Doe',
                  totalMembers: 10,
                );
              },
            );
          } else {
            return const Center(child: Text('No Groups available'));
          }
        });
  }

  Widget _allGroupsList() {
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
                print('iddddd: ${friend.friend.id}');
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, GroupInfoScreen.routeName),
                  child: const GroupTile(
                    image: 'https://blog.photofeeler.com/wp-content/uploads/2017/09/instagram-profile-picture-maker.jpg',
                    title: 'Poker mates',
                    recentMessage: 'Are we playing today?',
                    senderName: 'John Doe',
                    totalMembers: 10,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Groups available'));
          }
        });
  }
}
