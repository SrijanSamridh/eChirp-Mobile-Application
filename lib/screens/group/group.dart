import 'package:echirp/utils/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:echirp/screens/group/components/group_tile.dart';
import 'package:echirp/screens/group/groupInfo.dart';
import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/group/components/create_group.dart';

import '../../API/provider/group_provider.dart';
import '../chat/chat.dart';

class GroupScreen extends StatefulWidget {
  static const String routeName = '/group';

  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late bool _dataLoaded = false;

  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).fetchGroups().then((_) {
      // Set a delay to show "No Data Found" after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (!_dataLoaded) {
          setState(() {
            _dataLoaded = true;
          });
        }
      });
    });
    super.initState();
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
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<GroupProvider>(context, listen: false)
                      .fetchGroups();
                },
                child: _buildMyGroupsList()),
            RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<GroupProvider>(context, listen: false)
                      .fetchGroups();
                },
                child: _buildJoinedGroupsList()),
            RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<GroupProvider>(context, listen: false)
                      .fetchGroups();
                },
                child: _buildAllGroupsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildMyGroupsList() {
    final groupProvider = Provider.of<GroupProvider>(context);
    final myGroups = groupProvider.myGroups;
    Size size = MediaQuery.of(context).size;

    if (myGroups == null) {
      return _buildSkeletonLoader();
    }

    if (myGroups.isEmpty && _dataLoaded) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/under-development.json',
              height: size.height * 0.35),
          const Text("Opps! No Data Available, create a group today."),
        ],
      ));
    }

    return ListView.builder(
      itemCount: myGroups.length,
      itemBuilder: (context, index) {
        final group = myGroups[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        title: group.name.toString(),
                        image: '', id: group.groupId.toString(), participants: group.participants,
                      ))),
          child: GroupTile(
            image: group.imageUrl ?? '',
            title: group.name ?? '',
            recentMessage: 'Are we playing today?',
            senderName: 'John Doe',
            totalMembers: group.participants?.length ?? 0,
          ),
        );
      },
    );
  }

  Widget _buildJoinedGroupsList() {
    Size size = MediaQuery.of(context).size;
    final groupProvider = Provider.of<GroupProvider>(context);
    final joinedGroups = groupProvider.joinedGroups;

    if (joinedGroups == null) {
      return _buildSkeletonLoader();
    }

    if (joinedGroups.isEmpty && _dataLoaded) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/under-development.json',
              height: size.height * 0.35),
          const Text("Join a group today Swipe right."),
        ],
      ));
    }

    return ListView.builder(
      itemCount: joinedGroups.length,
      itemBuilder: (context, index) {
        final group = joinedGroups[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        title: group.name.toString(),
                        image: '', id: group.groupId.toString(), participants: group.participants,
                      ))),
          child: GroupTile(
            image: group.imageUrl ?? '',
            title: group.name ?? '',
            recentMessage: 'Are we playing today?',
            senderName: 'John Doe',
            totalMembers: group.participants?.length ?? 0,
          ),
        );
      },
    );
  }

  Widget _buildAllGroupsList() {
    Size size = MediaQuery.of(context).size;
    final groupProvider = Provider.of<GroupProvider>(context);
    final allGroups = groupProvider.allGroups;

    if (allGroups == null) {
      return _buildSkeletonLoader();
    }

    if (allGroups.isEmpty && _dataLoaded) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/under-development.json',
              height: size.height * 0.35),
          const Text("Opps! No Data Available, Create your own Group."),
        ],
      ));
    }

    return ListView.builder(
      itemCount: allGroups.length,
      itemBuilder: (context, index) {
        final group = allGroups[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              GroupInfoScreen.routeName,
            );
          },
          child: GroupTile(
            image: group.imageUrl ?? '',
            title: group.name ?? '',
            recentMessage: 'Are we playing today?',
            senderName: 'John Doe',
            totalMembers: group.participants?.length ?? 0,
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return SkeletonLoaders.groupTileSkeleton(context);
      },
    );
  }
}
