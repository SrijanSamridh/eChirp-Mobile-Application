import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/global_variabes.dart';

class MyEventCard extends StatelessWidget {
  const MyEventCard({
    super.key,
    required this.size,
    required this.imgUrl,
    required this.date,
    required this.time,
    required this.typeOfEvent,
    required this.location,
    required this.about,
    required this.visibility,
    required this.guest,
  });

  final Size size;
  final String imgUrl;
  final String date;
  final String time;
  final String typeOfEvent;
  final String location;
  final String about;
  final String visibility;
  final int guest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.13,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(91, 194, 194, 194),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image(
              image: AssetImage(imgUrl),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            height: size.height * 0.1,
            width: size.width * 0.015,
            decoration: BoxDecoration(
                color: GlobalVariables.kPrimaryColor,
                borderRadius: BorderRadius.circular(30.0)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$date at $time',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * 0.012),
                ),
                Text(
                  typeOfEvent,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: size.height * 0.016,
                    ),
                    Text(
                      location,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: size.height * 0.012),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.002),
                Expanded(
                  child: Text(
                    about,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: size.height * 0.012),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                visibility,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: size.height * 0.012),
              ),
              Text(
                '$guest guest',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: size.height * 0.012),
              ),
            ],
          )
        ],
      ),
    );
  }
}
