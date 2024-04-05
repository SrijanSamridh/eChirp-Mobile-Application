import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class GroupInfoScreen extends StatelessWidget {
  static const String routeName = "/groupInfo";

  const GroupInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back,color: Colors.white, size: 30)),
        ),
        body: Stack(
          children: [
            // Background Image
            Container(
              color: Colors.black,
              height: size.height * 0.4,
              child: Image.asset(
                'assets/images/Group 75.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            // Container with Overlay
            SingleChildScrollView(
              child: Container(
                height: size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.32),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Created by:',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12)),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 32,
                          width: size.width * 0.39,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: GlobalVariables.kPrimaryColor),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.black,
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/dummyDP.png',
                                      height: 26,
                                      width: 26,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              const Text(
                                "Meg Johnson",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Foodie We',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Text('23.1k Members',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[800])),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Category',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Text('Created on: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text('27 December 2022',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('Food & beverages',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        SizedBox(height: 4),
                        Text('Sub-category',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Brunch Party',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        SizedBox(height: 4),
                        Text('Description',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. flknmrfkmewkflmafedpkmfep.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: GlobalVariables.kPrimaryColor,
                          ),
                        ),
                        Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.18),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.1),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 26.0,
                            width: 26.0,
                            margin: EdgeInsets.only(left: size.width * 0.02),
                            decoration: BoxDecoration(
                                gradient: GlobalVariables.kPrimaryGradientColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                    color: GlobalVariables.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              child: Image.asset(
                                'assets/images/goupPP.png',
                                height: 25.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8.0),
                      const Text(
                        '33 Known friends',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ],
                  ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: Container(
                        width: size.width * 0.6,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            gradient: GlobalVariables.kPrimaryGradientColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Request to Join Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'All Groups',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return

                                // Rounded Corner Containers (Group Images)
                                Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: GlobalVariables.kPrimaryColor,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text("Lorem")
                                ],
                              ),
                            );
                          }),
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
