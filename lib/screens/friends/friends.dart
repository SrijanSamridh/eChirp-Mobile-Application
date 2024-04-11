// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:echirp/utils/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/friends/components/custom_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../API/provider/friend_provider.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends';

  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late Future<void> potentialFriendList;
  late Future<void> friendsList;
  late Future<void> friendRequestList;

  @override
  void initState() {
    super.initState();
    potentialFriendList = _initPotentialFriendList();
    friendsList = _initFriendsList();
    friendRequestList = _initFriendRequestList();
  }

  Future<void> _initPotentialFriendList() async {
    await Provider.of<FriendProvider>(context, listen: false)
        .fetchPotentialFriends();
  }

  Future<void> _initFriendsList() async {
    await Provider.of<FriendProvider>(context, listen: false).fetchFriends();
  }

  Future<void> _initFriendRequestList() async {
    await Provider.of<FriendProvider>(context, listen: false)
        .fetchFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: CustomAppBar(
            size: size,
            title: 'Find Friends',
            showCreate: false,
            tabs: const <Widget>[
              Tab(text: "Friends"),
              Tab(text: "Potential"),
              Tab(text: "Requests"),
            ],
            searchfor: 'people',
            onPressed: () {},
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: () async {
                await Provider.of<FriendProvider>(context, listen: false)
                    .fetchFriends();
              },
              child: FutureBuilder<void>(
                future: friendsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const FriendsListSkeleton();
                  } else {
                    return const FriendsList();
                  }
                },
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                await Provider.of<FriendProvider>(context, listen: false)
                    .fetchPotentialFriends();
              },
              child: FutureBuilder<void>(
                future: potentialFriendList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PotentialFriendsListSkeleton();
                  } else {
                    return const PotentialFriendsList();
                  }
                },
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                await Provider.of<FriendProvider>(context, listen: false)
                    .fetchFriendRequests();
              },
              child: const FriendRequestsList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendsListSkeleton extends StatelessWidget {
  const FriendsListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust as needed
      itemBuilder: (context, index) {
        return SkeletonLoaders.customTileSkeleton(context);
      },
    );
  }
}

class PotentialFriendsListSkeleton extends StatelessWidget {
  const PotentialFriendsListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust as needed
      itemBuilder: (context, index) {
        return SkeletonLoaders.customTileSkeleton(context);
      },
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendProvider = Provider.of<FriendProvider>(context);
    final friends = friendProvider.myFriends;

    return friends == null
        ? const Center(child: CircularProgressIndicator())
        : friends.isEmpty
            ? const Center(child: Text('No friends available'))
            : ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return CustomTile(
                    title: friend.username ?? 'Friend Name',
                    subTitle: friend.bio ?? 'Friend Bio',
                    image: "",
                    mutuals: friend.numberOfFriends.toString(),
                    myFriend: true,
                    id: friend.id ?? 'Friend ID',
                  );
                },
              );
  }
}

class PotentialFriendsList extends StatelessWidget {
  const PotentialFriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendProvider = Provider.of<FriendProvider>(context);
    final potentialFriends = friendProvider.potentialFriends?.potentialFriends;

    return potentialFriends == null
        ? const Center(child: CircularProgressIndicator())
        : potentialFriends.isEmpty
            ? const Center(child: Text('No potential friends available'))
            : ListView.builder(
                itemCount: potentialFriends.length,
                itemBuilder: (context, index) {
                  final data = potentialFriends[index];
                  return CustomTile(
                    title: data.friend.username,
                    subTitle: 'Potential Friend Subtitle',
                    image: "",
                    mutuals: data.count.toString(), // Dummy data
                    myFriend: false,
                    id: data.friend.id,
                  );
                },
              );
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final friendProvider = Provider.of<FriendProvider>(context);
    final friendRequests = friendProvider.friendRequests;

    return friendRequests == null
        ? const Center(child: CircularProgressIndicator())
        : friendRequests.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/under-development.json',
                      height: size.height * 0.35),
                  const Text(
                      "Hey! No Request Available, Why don't you request?"),
                ],
              ))
            : ListView.builder(
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  final friend = friendRequests[index];
                  return CustomTile(
                    title: friend.username ?? 'Friend Request Name',
                    subTitle: friend.bio ?? 'Friend Request Bio',
                    image: "",
                    mutuals: friend.numberOfFriends.toString(),
                    myFriend: true,
                    requests: true,
                    id: friend.id ?? 'Friend Request ID',
                  );
                },
              );
  }
}
