import 'package:echirp/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../API/provider/group_provider.dart';
import '../../utils/data_formatter.dart';

class GroupInfoScreen extends StatelessWidget {
  static const String routeName = "/groupInfo";
  final VoidCallback onPressed;
  final int index;

  const GroupInfoScreen(
      {Key? key, required this.onPressed, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupProvider>(context, listen: false).allGroups;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30)),
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
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.32),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Created by:',
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 12)),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 32,
                      width: size.width * 0.39,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: GlobalVariables.colors.primary),
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
                          Text(
                            "${groups?[index].owner?.username}",
                            style: const TextStyle(
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
                    Text(
                      '${groups?[index].name}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    Text(
                        '${groups?[index].participants?.length} ${groups![index].participants!.length > 1 ? 'Members' : 'Member'}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[800])),
                  ],
                ),
                const SizedBox(height: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Category',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            const Text('Created on: ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(DataFormatter.formatDate('${groups[index].createdAt}'),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${groups[index].category}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    const Text('Sub-category',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("${groups[index].subCategory}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    const Text('Description',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      groups[index].description != null
                          ? '${groups[index].description}'
                          : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla consequat odio in turpis tempor condimentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. flknmrfkmewkflmafedpkmfep.",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: GlobalVariables.colors.primary,
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
                                  gradient:
                                      GlobalVariables.colors.primaryGradient,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  border: Border.all(
                                      color: GlobalVariables.colors.primary)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
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
                                  gradient:
                                      GlobalVariables.colors.primaryGradient,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  border: Border.all(
                                      color: GlobalVariables.colors.primary)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
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
                                  gradient:
                                      GlobalVariables.colors.primaryGradient,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  border: Border.all(
                                      color: GlobalVariables.colors.primary)),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
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
                        gradient: GlobalVariables.colors.primaryGradient,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextButton(
                      onPressed: onPressed,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      // Rounded Corner Containers (Group Images)
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: GlobalVariables.colors.primary,
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Text("Lorem")
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
