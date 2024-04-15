// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:echirp/API/controller/group.controller.dart';
import 'package:echirp/API/models/group.models.dart';

class GroupProvider extends ChangeNotifier {
  final GroupController _groupController = GroupController();

  List<Group>? _myGroups;
  List<Group>? _joinedGroups;
  List<Group>? _allGroups;

  List<Group>? get myGroups => _myGroups;
  List<Group>? get joinedGroups => _joinedGroups;
  List<Group>? get allGroups => _allGroups;

  Future<void> fetchGroups() async {
    try {
      final myGroupsResponse = await _groupController.fetchGroups("owned");
      _myGroups = myGroupsResponse?.groups;
      print(_myGroups?.first.groupId);

      final joinedGroupsResponse = await _groupController.fetchGroups("joined");
      _joinedGroups = joinedGroupsResponse?.groups;

      final allGroupsResponse = await _groupController.fetchGroups("all");
      _allGroups = allGroupsResponse?.groups;

      notifyListeners();
    } catch (e) {
      print('Error fetching groups: $e');
    }
  }
}
