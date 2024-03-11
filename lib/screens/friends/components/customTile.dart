import 'package:echirp/screens/profile/profile.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String mutuals;
  final String image;
  final bool myFriend;
  final String id;

  const CustomTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.mutuals,
    required this.myFriend,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24),
      child: 
          GestureDetector(
            onTap: () {
             Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(id: id,loggedUser: false,)));
            },
            child: Container(
              height: size.height / 8,
              decoration: BoxDecoration(
                color: Color(0xffF4F3F3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Color(0xff565656),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                          Text(
                            subTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff565656),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: GlobalVariables.kPrimaryGradientColor),
                            child: TextButton(
                              onPressed: () {
                                myFriend
                                ?(){}
                                :(){};
                              },
                              child: Text(
                                myFriend
                                ? 'remove'
                                : 'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                ],
              ),
            ),
          ),
          
    );
  }
}
