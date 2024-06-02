import 'package:echirp/API/services/helper/helper.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_btn.dart';
import '../../../utils/data_formatter.dart';

class JoinSectionCard extends StatelessWidget {
  const JoinSectionCard({
    Key? key,
    required this.size,
    required this.imgUrl,
    required this.profileImg,
    required this.username,
    required this.typeOfEvent,
    required this.date,
    required this.time,
    required this.location,
    required this.onPressed,
    required this.shareEventCode,
  }) : super(key: key);

  final Size size;
  final String imgUrl;
  final String profileImg;
  final String username;
  final String typeOfEvent;
  final DateTime? date;
  final String time;
  final String location;
  final String shareEventCode;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.055,
        vertical: size.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image(
              image: AssetImage(imgUrl),
              height: size.height * 0.3,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.13,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(208, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
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
                              "By $username",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Helper().share(context, shareEventCode);
                          },
                          icon: const Icon(Icons.share),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: size.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.lock_clock,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Text(
                                    ' ${DataFormatter.formatDateWithFlag(date.toString(), false)} at ${DataFormatter.formatTimeWithoutSeconds(time)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Text(
                                    location,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomBtn(
                          text: 'Join event',
                          size: size,
                          onPressed: onPressed,
                          width: size.width * 0.025,
                          height: size.height * 0.015,
                          textSize: size.height * 0.015,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
