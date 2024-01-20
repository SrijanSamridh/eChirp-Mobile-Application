import 'package:flutter/material.dart';

class EventBriefCard extends StatelessWidget {
  const EventBriefCard({
    super.key,
    required this.size,
    required this.imageUrl,
    required this.profileImg,
    required this.userName, required this.dateTime, required this.location,
  });

  final Size size;
  final String profileImg;
  final String userName;
  final String imageUrl;
  final String dateTime;
  final String location;

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
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        profileImg,
                        height: 30,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      userName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: size.height * 0.02,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          dateTime,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.014),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: size.height * 0.02,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          location,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.014),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
