import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:echirp/screens/profile/profile.dart';
import 'package:echirp/utils/global_variabes.dart';

import '../../../API/provider/friend_provider.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String mutuals;
  final String image;
  final bool myFriend;
  final bool requests;
  final String id;

  const CustomTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.mutuals,
    required this.myFriend,
    required this.id,
    this.requests = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                id: id,
                loggedUser: false,
              ),
            ),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              margin: EdgeInsets.only(right: size.width * 0.03),
              height: size.height * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffF4F3F3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: CircleAvatar(
                      radius: 28,
                      child: image.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                image,
                                height: 56,
                                width: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(
                              title.substring(0, 1).toUpperCase(),
                              style: const TextStyle(fontSize: 14),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Color(0xff565656),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          subTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff565656),
                          ),
                        ),
                      ],
                    ),
                  ),
                  myFriend == false && requests == false
                            ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      mutuals == '1'
                                          ? "$mutuals mutual"
                                          : "$mutuals mutuals",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff565656),
                                      ),
                                    ),
                                ),
                              ],
                            )
                            : const SizedBox(),
                ],
              ),
            ),
            requests == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            gradient: GlobalVariables.kPrimaryGradientColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              myFriend
                                  ? Provider.of<FriendProvider>(context,
                                          listen: false)
                                      .removeFriend(context, id)
                                  : Provider.of<FriendProvider>(context,
                                          listen: false)
                                      .sendFriendRequest(context, id);
                            },
                            icon: Icon(
                              myFriend ? Icons.remove : Icons.add,
                              color: Colors.white,
                              size: size.height * 0.02,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: GlobalVariables.kPrimaryGradientColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Provider.of<FriendProvider>(context,
                                      listen: false)
                                  .acceptFriendRequest(context, id);
                            },
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: size.height * 0.02,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: GlobalVariables.kPrimaryGradientColor,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: size.height * 0.02,
                            ),
                          ),
                        ),
                      ],
                    ),
          ],
        ),
      ),
    );
  }
}
