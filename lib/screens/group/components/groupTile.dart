import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final String image;
  final String title;
  final String recentMessage;
  final String senderName;
  final int totalMembers;

  const GroupTile({
    Key? key,
    required this.image,
    required this.title,
    required this.recentMessage,
    required this.senderName,
    required this.totalMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Container(
                height: size.height * 0.08,
                decoration: BoxDecoration(
                  color: Color(0xffF4F3F3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      child: CircleAvatar(
                        radius: 26,
                        child: image.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  image,
                                  height: 52,
                                  width: 52,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Text(
                                title.substring(0, 1).toUpperCase(),
                                style: TextStyle(fontSize: 14),
                              ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.66,
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Color(0xff565656),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "${totalMembers.toString()} members",
                                //overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Color(0xff948A8A),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                            Text(
                              "${senderName}: ${recentMessage}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff565656),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

// Example Usage:
/*
GroupTile(
  avatarImageUrl: 'https://example.com/avatar.jpg',
  groupName: 'Football Lovers',
  recentMessage: 'Are we playing today?',
  senderName: 'John Doe',
  totalMembers: 10,
),
*/
