import 'package:echirp/API/models/group.models.dart';
import 'package:echirp/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../API/provider/group_provider.dart';
import '../../../utils/data_formatter.dart';

class GroupDetailsPage extends StatefulWidget {
  static const String routeName = '/group-detail';
  final int index;
  final bool myGroups;

  const GroupDetailsPage({super.key, required this.index, required this.myGroups});

  @override
  State<GroupDetailsPage> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final groups = widget.myGroups
        ? Provider.of<GroupProvider>(context, listen: false).myGroups
        : Provider.of<GroupProvider>(context, listen: false).joinedGroups;
    Group? group = groups?[widget.index];
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: size.height * 0.012),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGroupHeader(size, group),
            SizedBox(height: size.height * 0.02),
            _buildMembersList(group),
            const SizedBox(height: 20),
            _buildActions(),
            Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Created ${DataFormatter.formatDate('${group?.createdAt}')}',
                // 'Created 13 June 2023', create a date time formatter method from 2024-04-19 19:27:06.116Z to 19 April 2024
                style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupHeader(Size size, Group? group) {
    return Container(
      height: size.height * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: GlobalVariables.colors.chatBubble,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const CircleAvatar(radius: 50, backgroundColor: Colors.white),
          const SizedBox(height: 10.0),
          Text(
            (group?.name ?? '').toUpperCase(),
            style: TextStyle(
              fontSize: size.height * 0.025,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Group Owner: ${group?.owner?.username}',
            style: TextStyle(fontSize: size.height * 0.015),
          ),
          Text(
            'Group: ${group?.participants?.length ?? 0} members',
            style: TextStyle(fontSize: size.height * 0.015),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList(dynamic group) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Icon(
                    Icons.people_rounded,
                    color: GlobalVariables.colors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Add People to Group",
                style: TextStyle(
                  color: GlobalVariables.colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: group?.participants?.length ?? 0,
              itemBuilder: (context, index) {
                return _buildMemberTile(
                  group?.participants?[index].userId ?? 'Unknown',
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey.withOpacity(0.3),
                  height: 1.0,
                );
              },
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _buildMemberTile(String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              const SizedBox(width: 10),
              const CircleAvatar(backgroundColor: Colors.black),
              const SizedBox(width: 10.0),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
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
            child: Divider(color: Colors.grey, height: 0),
          ),
          _buildActionTile('Exit Group'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Divider(color: Colors.grey, height: 0),
          ),
          _buildActionTile('Report Group'),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
      onTap: () {
        // Handle tile tap
      },
      dense: true,
    );
  }
}
