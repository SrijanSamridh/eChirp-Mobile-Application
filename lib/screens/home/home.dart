import 'package:flutter/material.dart';

import '../../components/custom_clipper.dart';
import '../../components/custom_search_bar.dart';
import '../../components/headling_with_hyperlink.dart';

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
        body: Column(
      children: [
        Stack(
          children: [
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
                    CustomSearchBar(onPressed: () {}, searchFor: 'events'),
                  ],
                ),
              ),
            )
          ],
        ),

        // ignore: prefer_const_constructors
        HeadlineWithHyperLink(headingText: 'Events', onPressed: () {}),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              EventBriefCard(
                size: size,
                imageUrl: 'assets/images/dummy_event.png',
              ),
              EventBriefCard(
                size: size,
                imageUrl: 'assets/images/dummy_image.jpg',
              ),
              EventBriefCard(
                size: size,
                imageUrl: 'assets/images/dummy_event.png',
              ),
            ],
          ),
        ),
        HeadlineWithHyperLink(headingText: 'Mutual Friends', onPressed: () {})
      ],
    ));
  }
}

class EventBriefCard extends StatelessWidget {
  const EventBriefCard({
    super.key,
    required this.size,
    required this.imageUrl,
  });

  final Size size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      height: size.height * 0.25,
      width: size.width * 0.74,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(imageUrl, fit: BoxFit.fitWidth),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width * 0.74,
              height: size.height * 0.1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        'assets/images/dummyDP.png',
                        height: 30,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text("By Meg Rigden",
                    style: TextStyle(color: Colors.white),)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
