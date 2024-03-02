import 'package:echirp/components/custom_app_bar.dart';
import 'package:echirp/screens/friends/components/customTile.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  static const String routeName = '/friends';
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.18),
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
                  onPressed: () {})),
          body: TabBarView(children: <Widget>[
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomTile(
                      title: "Ravneet",
                      subTitle: "An ordinary, extremely boring person.",
                      Image: "")
                ],
              ),
            ),
            Container()
          ]),
        ));
  }
}
