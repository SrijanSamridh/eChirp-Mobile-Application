import 'package:echirp/API/models/friends.model.dart';
import 'package:flutter/material.dart';
import 'package:echirp/API/controller/friend.controller.dart';
import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/friends/components/customTile.dart';

import '../search/search.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends';

  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late Future<List<Friends>?> _myFriends;
  final friendFuture = FriendController();

  @override
  void initState() {
    super.initState();
    _myFriends = _initFriends();
  }

  Future<List<Friends>?> _initFriends() async {
    try {

      return friendFuture.fetchMyFriends('/friends');
    } catch (e) {
      debugPrint('Error initializing friends: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.18),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                },
                child: CustomAppBar(
                    size: size,
                    title: 'Find People',
                    showCreate: false,
                    tabs: const <Widget>[
                      Tab(
                        text: "My Friends",
                      ),
                      Tab(
                        text: "Potential Friends",
                      ),
                    ],
                    searchfor: 'people',
                    onPressed: () {}),
              )),
          body: TabBarView(children: <Widget>[
            _myFriendsList(),
            Container()
          ]),
        ));
  }

  Widget _myFriendsList()
  {
    return FutureBuilder<List<Friends>?>(
        future: _myFriends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final friends = snapshot.data!;
            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
                  child: CustomTile(
                    title: friend.username ?? '',
                    subTitle: friend.bio ?? '',
                    Image: '', // Provide image URL here if applicable
                  ),
                );
              },
            );
          } else {
            
            return Center(child: Text('No friends available'));
          }
        });
  }
}
