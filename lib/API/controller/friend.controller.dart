// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/friendRequest.models.dart';
import '../models/friends.model.dart';
import '../models/potential_friends.dart';
import '../models/userData.model.dart';
import '../services/api_client.dart';

class FriendController {
  final client = ApiClient();

  Future<List<Friends>?> fetchMyFriends(String route) async {
    try {
      final response = await client.get("/friend$route");
      if (response == null || response.isEmpty) return null;

      final List<dynamic> decodedResponse = json.decode(response);
      if (decodedResponse.isEmpty) return null;

      return decodedResponse
          .map<Friends>((friendData) => Friends.fromJson(friendData))
          .toList();
    } catch (e) {
      debugPrint('Error fetching friends: $e');
      return null;
    }
  }

  Future<List<Friends>?> searchPeople(String route, String query) async {
    try {
      final response = await client.get("/friend$route?term=$query");
      if (response == null || response.isEmpty) return null;

      final List<dynamic> decodedResponse = json.decode(response);
      if (decodedResponse.isEmpty) return null;

      return decodedResponse
          .map<Friends>((friendData) => Friends.fromJson(friendData))
          .toList();
    } catch (e) {
      debugPrint('Error searching people: $e');
      return null;
    }
  }

  Future<PotentialFriends?> fetchPotentialFriends(String route) async {
    try {
      final response = await client.get("/friend$route");
      if (response == null || response.isEmpty) return null;

      final decodedResponse = json.decode(response);
      final potentialFriendsData = decodedResponse['potentialFriends'];

      if (potentialFriendsData != null && potentialFriendsData is List) {
        final potentialFriends = potentialFriendsData
            .map<PotentialFriend>((data) => PotentialFriend.fromJson(data))
            .toList();
        return PotentialFriends(potentialFriends: potentialFriends);
      } else {
        debugPrint('Potential friends data not found in response');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching potential friends: $e');
      return null;
    }
  }

  Future<List<FriendRequests>?> fetchFriendRequests(String route) async {
    try {
      final response = await client.get("/friend$route");
      if (response == null || response.isEmpty) return null;

      final List<dynamic> decodedResponse = json.decode(response);
      if (decodedResponse.isEmpty) return [];
      print(decodedResponse
          .map<FriendRequests>((data) => FriendRequests.fromJson(data))
          .toList());
      return decodedResponse
          .map<FriendRequests>((data) => FriendRequests.fromJson(data))
          .toList();
    } catch (e) {
      debugPrint('Error fetching friend requests: $e');
      return null;
    }
  }

  Future<void> removeFriend(BuildContext context, String id) async {
    try {
      final response = await client.delete("/friend/remove/$id");
      if (response != null) {
        if (response.containsKey('error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response["error"]}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Friend removed successfully')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error removing friend: Response is null')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing friend: $e')),
      );
    }
  }

  Future<void> acceptFriendRequest(
      BuildContext context, String friendId) async {
    try {
      final response =
          await client.post("/friend/accept", {"friendID": friendId});
      if (response != null) {
        if (response.containsKey('error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response["error"]}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Friend request accepted successfully')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Error accepting friend request: Response is null')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accepting friend request: $e')),
      );
    }
  }

  Future<void> sendFriendRequest(BuildContext context, String friendId) async {
    try {
      final response =
          await client.post("/friend/send", {"friendID": friendId});
      if (response != null) {
        if (response.containsKey('error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response["error"]}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Friend request sent successfully')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error sending friend request: Response is null')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending friend request: $e')),
      );
    }
  }

  Future<UserData?> fetchFriendProfile(String route) async {
    try {
      final response = await client.get("/friend/profile$route");
      if (response == null || response.isEmpty) return null;

      final decodedResponse = json.decode(response);
      if (decodedResponse is! Map<String, dynamic>) return null;

      return UserData.fromJson(decodedResponse);
    } catch (e) {
      debugPrint('Error fetching friend profile: $e');
      return null;
    }
  }
}
