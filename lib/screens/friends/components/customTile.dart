import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String mutuals;
  final String image;

  const CustomTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.mutuals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24),
      child: Stack(
        children: [
          Container(
            height: size.height / 8,
            width: size.width / 1.09,
            decoration: BoxDecoration(
              color: Color(0xffF4F3F3),
              borderRadius: BorderRadius.circular(18),
            ),
            clipBehavior: Clip.none,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: 80,
                    child: CircleAvatar(
                      radius: 70,
                      child: image.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                image,
                                height: 32,
                                width: 32,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(
                              title.substring(0, 1).toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Color(0xff565656),
                        fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(fontSize: 14, color: Color(0xff565656)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -20, // Adjust position as needed
            top: size.height / 16 - 10, // Adjust position as needed
            child: Container(
              width: 50,
              clipBehavior: Clip.none, // Adjust icon size as needed
              decoration: BoxDecoration(
                gradient: GlobalVariables.kPrimaryGradientColor, // Adjust icon background color
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add, // Your desired icon
                color: Colors.white, // Icon color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
