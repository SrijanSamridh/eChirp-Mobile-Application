import 'package:echirp/utils/data_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../utils/global_variables.dart';

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
              image: NetworkImage(imgUrl),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            height: size.height * 0.1,
            width: size.width * 0.015,
            decoration: BoxDecoration(
                color: GlobalVariables.colors.primary,
                borderRadius: BorderRadius.circular(30.0)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    '${DataFormatter.formatDateWithFlag(date.toString(), false)} at ${DataFormatter.formatTimeWithoutSeconds(time)}',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: size.height * 0.012),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    typeOfEvent,
                    textAlign: TextAlign.left,
                  ),
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
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: size.height * 0.012),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.002),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city_sharp,
                        size: size.height * 0.016,
                      ),
                      Expanded(
                        child: Text(
                          about,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: size.height * 0.012),
                        ),
                      ),
                    ],
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
