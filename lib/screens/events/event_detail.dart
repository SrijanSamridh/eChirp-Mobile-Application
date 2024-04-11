import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/eventBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content Container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              //padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Orange Container
                  Container(
                    decoration: BoxDecoration(
                      gradient: GlobalVariables.kPrimaryGradientColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 110,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    'assets/images/dummyDP.png',
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date & Time',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Venue',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Description
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Number of Mutual Friends
                        Text(
                          '12 Mutual Friends',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Row of RRECT Images
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        images('assets/images/dummy_event.png'),
                        images('assets/images/dummy_event.png'),
                        images('assets/images/dummy_event.png'),
                        images('assets/images/dummy_event.png'),
                    
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Tile with Leading Avatar, Title, Subtitle, and Trailing Join Button
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/dummyDP.png'),
                    ),
                    title: Text(
                      'Created by:',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Meg Rigden',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Friends',
                          style: TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)
                        )
                        
                      ],
                    ),
                    trailing: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: GlobalVariables.kPrimaryGradientColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Joined',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget images(String url){
  return Container(
                        color: Colors.white10,
                        height: 80,
                        width: 90,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              url,
                              fit: BoxFit.fill,
                            )),
                      );

}
