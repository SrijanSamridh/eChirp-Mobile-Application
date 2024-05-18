// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:echirp/API/controller/friend.controller.dart';
import 'package:echirp/API/models/friends.model.dart';
import 'package:echirp/API/models/potential_friends.dart';
import 'package:echirp/API/models/friendRequest.models.dart';

class FriendProvider extends ChangeNotifier {
  final FriendController friendController = FriendController();
  List<Friends>? _myFriends;
  PotentialFriends? _potentialFriends;
  List<FriendRequests>? _friendRequests;
  bool _isLoading = false;

  List<Friends>? get myFriends => _myFriends;
  PotentialFriends? get potentialFriends => _potentialFriends;
  List<FriendRequests>? get friendRequests => _friendRequests;
  bool get isLoading => _isLoading;

  Future<void> fetchFriends() async {
    _isLoading = true;
    notifyListeners();
    try {
      _myFriends = await friendController.fetchMyFriends('/friends');
    } catch (e) {
      print('Error fetching friends: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPotentialFriends() async {
    _isLoading = true;
    notifyListeners();
    try {
      _potentialFriends =
          await friendController.fetchPotentialFriends('/potential');
      for (int i = 0; i < _potentialFriends!.potentialFriends.length; i++) {
        print("${_potentialFriends?.potentialFriends[i].friend.username} : ${_potentialFriends?.potentialFriends[i].count} mutual");
      }
    } catch (e) {
      print('Error fetching potential friends: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFriendRequests() async {
    _isLoading = true;
    notifyListeners();
    try {
      print("Fetching Requests...");
      _friendRequests = await friendController.fetchFriendRequests('/requests');
      print(_friendRequests);
    } catch (e) {
      print('Error fetching friend requests: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeFriend(BuildContext context, String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await friendController.removeFriend(context, id);
      // Refresh the friends list after removing a friend
      await fetchFriends();
    } catch (e) {
      print('Error removing friend: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendFriendRequest(BuildContext context, String friendID) async {
    _isLoading = true;
    notifyListeners();
    try {
      await friendController.sendFriendRequest(context, friendID);
      // Refresh the potential friends list after sending a request
      await fetchPotentialFriends();
    } catch (e) {
      print('Error sending friend request: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> acceptFriendRequest(
      BuildContext context, String friendID) async {
    _isLoading = true;
    notifyListeners();
    try {
      await friendController.acceptFriendRequest(context, friendID);
      // Refresh the friend requests list after accepting a request
      await fetchFriendRequests();
      // Refresh the friends list after accepting a request
      await fetchFriends();
    } catch (e) {
      print('Error accepting friend request: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
