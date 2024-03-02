import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/friends.model.dart';
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
      debugPrint('Error fetching events: $e');
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
print("printinting friend list");
print(friendsList);
print("printrd list");
return friendsList;

    } catch (e) {
      debugPrint('Error fetching events: $e');
      return null;
    }
  }
}
