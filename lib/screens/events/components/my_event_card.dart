import 'package:flutter/material.dart';

import '../../../utils/global_variabes.dart';

class MyEventCard extends StatelessWidget {
  const MyEventCard({
    super.key,
    required this.size,
  });

  final Size size;

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
            child: const Image(
              image: AssetImage('assets/images/dummy_event.png'),
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
                  '23 Dec at 10:00 am',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * 0.012),
                ),
                const Text(
                  'Poetry Event',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: size.height * 0.016,
                    ),
                    Text(
                      'Mumbai, Maharshtra , India ',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: size.height * 0.012),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.002),
                Text(
                  'Lorem ipsum dolor sit amet, conct adipiscing elit.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: size.height * 0.012),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                'Public',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: size.height * 0.012),
              ),
              Text(
                '100 guest',
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
