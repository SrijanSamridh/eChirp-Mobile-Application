import 'dart:convert';

import 'package:echirp/API/models/potentialFriends.dart';
import 'package:flutter/material.dart';

import '../models/friends.model.dart';
import '../models/userData.model.dart';
import '../services/base_client.dart';

class FriendController {
  final client = BaseClient();

  Future<List<Friends>?> fetchMyFriends(String route) async {
    try {
      final response = await client.get("/friend$route");
      //debugPrint(response.body);

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final List<dynamic> decodedResponse = json.decode(response);
      //debugPrint(decodedResponse.toString());

if (decodedResponse.isEmpty) {
  debugPrint('Empty response received');
  return null;
}

final List<Friends> friendsList = decodedResponse.map<Friends>((friendData) {
  return Friends.fromJson(friendData as Map<String, dynamic>);
}).toList();
print("printinting friend list");
print(friendsList);
print("printrd list");
return friendsList;

    } catch (e) {
      debugPrint('Error fetching potentialFriends: $e');
      return null;
    }
  }

  Future<List<Friends>?> searchPeople(String route, String query) async {
    try {
      final response = await client.get("/friend$route?term=$query");
      //debugPrint(response.body);

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final List<dynamic> decodedResponse = json.decode(response);
      //debugPrint(decodedResponse.toString());

if (decodedResponse.isEmpty) {
  debugPrint('Empty response received');
  return null;
}

final List<Friends> friendsList = decodedResponse.map<Friends>((friendData) {
  return Friends.fromJson(friendData as Map<String, dynamic>);
}).toList();

return friendsList;

    } catch (e) {
      debugPrint('Error fetching potentialFriends: $e');
      return null;
    }
  }




Future<PotentialFriends?> fetchPotentialFriends(String route) async {
  try {
      final response = await client.get("/friend$route");

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }

      final potentialFriendsData = decodedResponse['potentialFriends'];

      if (potentialFriendsData != null && potentialFriendsData is List) {
        final potentialFriends = potentialFriendsData
            .map<PotentialFriend>((potentialFriendsData) => PotentialFriend.fromJson(potentialFriendsData))
            .toList();
            print(PotentialFriends(potentialFriends: potentialFriends));
        return PotentialFriends(potentialFriends: potentialFriends);
      } else {
        debugPrint('Events data not found in response');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching potentialFriends: $e');
      return null;
    }
}

 Future<UserData?> fetchFriendProfile(String route) async {
    try {
      print('friend id: $route');
      final response = await client.get("/friend/profile$route");

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      } else{
        return UserData.fromJson(decodedResponse);
      }
      
    } catch (e) {
      debugPrint('Error fetching friend data: $e');
      return null;
    }
  }

}
