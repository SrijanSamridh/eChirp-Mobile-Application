import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class GroupDetailsPage extends StatefulWidget {
  static const String routeName = '/group-detail';
  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              'Edit',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: GlobalVariables.chatBubbleColor,
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Football Lovers'.toUpperCase(),
                      style: TextStyle(
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Group: 22.3k members',
                      style: TextStyle(fontSize: size.height * 0.015),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                //padding: EdgeInsets.all(20.0)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                //shape: BoxShape.circle,
                                color: Colors.grey[300]),
                            child: const Center(
                                child: Icon(Icons.people_rounded,
                                    color: GlobalVariables.kPrimaryColor))),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Add People to Group",
                            style: TextStyle(
                                color: GlobalVariables.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16))
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildMemberTile("Richard james");
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    _buildActionTile('Clear Chat'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 0,
                      ),
                    ),
                    _buildActionTile('Exit Group'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 0,
                      ),
                    ),
                    _buildActionTile('Report Group'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Created 13 June 2023',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberTile(String title) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 1.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile(String title) {
    return Container(
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
        onTap: () {
          // Handle tile tap
        },
        dense: true,
      ),
    );
  }
}
