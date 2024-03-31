// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/friends/components/customTile.dart';
import 'package:provider/provider.dart';

import '../../API/provider/friend_provider.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  const SkeletonLoader({
    Key? key,
    this.width = double.infinity,
    this.height = 16.0,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}


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
          preferredSize: const Size.fromHeight(200),
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
      itemCount: 5, // Adjust as needed
      itemBuilder: (context, index) {
        return const ListTile(
          leading: SkeletonLoader(width: 48.0, height: 48.0),
          title: SkeletonLoader(width: 100.0),
          subtitle: SkeletonLoader(width: 150.0),
        );
      },
    );
  }
}

class PotentialFriendsListSkeleton extends StatelessWidget {
  const PotentialFriendsListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Adjust as needed
      itemBuilder: (context, index) {
        return const ListTile(
          leading: SkeletonLoader(width: 48.0, height: 48.0),
          title: SkeletonLoader(width: 100.0),
        );
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
                    title: friend.username ?? '',
                    subTitle: friend.bio ?? '',
                    image: '',
                    mutuals: friend.numberOfFriends.toString(),
                    myFriend: true,
                    id: friend.id ?? '',
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
                  final friend = potentialFriends[index].friend;
                  return CustomTile(
                    title: friend.username ?? '',
                    subTitle: '',
                    image: '',
                    mutuals: '',
                    myFriend: false,
                    id: friend.id ?? '',
                  );
                },
              );
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final friendProvider = Provider.of<FriendProvider>(context);
    final friendRequests = friendProvider.friendRequests;

    return friendRequests == null
        ? const Center(child: CircularProgressIndicator())
        : friendRequests.isEmpty
            ? const Center(child: Text('No friend requests available'))
            : ListView.builder(
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  final friend = friendRequests[index];
                  return CustomTile(
                    title: friend.username ?? '',
                    subTitle: friend.bio ?? '',
                    image: '',
                    mutuals: friend.numberOfFriends.toString(),
                    myFriend: true,
                    requests: true,
                    id: friend.id ?? '',
                  );
                },
              );
  }
}
