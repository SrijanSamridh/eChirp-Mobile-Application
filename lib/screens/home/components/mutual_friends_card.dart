import 'package:flutter/material.dart';

class MutualFriendCard extends StatelessWidget {
  const MutualFriendCard({
    super.key,
    required this.size,
    required this.profileImg,
    required this.userName,
    required this.mutualCount,
    required this.selectedColor,
    required this.textColor,
  });

  final Size size;
  final String profileImg;
  final String userName;
  final int mutualCount;
  final LinearGradient selectedColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        vertical: size.height * 0.01,
      ),
      height: size.height * 0.1,
      width: size.width * 0.36,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.015),
      decoration: BoxDecoration(
        gradient: selectedColor,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CircleAvatar(
          radius: size.height * 0.035,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image(
                image: AssetImage(profileImg),
                height: size.height * 0.2,
              )),
        ),
        const SizedBox(height: 10.0),
        Text(
          userName,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.018),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "$mutualCount mutual friend",
          style: TextStyle(
              fontSize: size.height * 0.012,
              color: const Color.fromARGB(255, 67, 66, 66),
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
