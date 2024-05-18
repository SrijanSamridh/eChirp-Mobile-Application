// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:echirp/API/services/base_client.dart';
import 'package:http/http.dart' as http;
import '../models/group.models.dart';

class GroupController {
  final client = BaseClient();

  Future<Groups> createGroup(Map<String, dynamic> requestBody) async {
    // Get Token
    String token = await BaseClient().getToken();

    // Header Config
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };

    // Make the POST request
    try {
      final http.Response response = await http.post(
        Uri.parse("$baseUrl/groups"),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract relevant data from the response
        String message = responseData['message'];
        Map<String, dynamic> groupData = responseData['group'];

        // Create Group instance
        Group group = Group.fromJson(groupData);

        // Create Groups instance
        Groups groups = Groups(message: message, group: group);

        return groups;
      } else {
        // Handle non-successful status codes
        print('Failed with status code ${response.statusCode}');
        throw Exception('Failed with status code ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error creating group: $e');
      throw Exception('Error creating group: $e');
    }
  }

  Future<Groups?> fetchGroups(String type) async {
    try {
      var response;
      if (type == "all") {
        response = await client.get("/groups/$type");
      } else {
        response = await client.get("/groups?type=$type");
      }
      // print("\n\n\n$type :: ${response.toString()}");
      if (response == null || response.isEmpty) {
        print('Unexpected response format: $response');
        return null;
      }

      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        print('Unexpected response format: $decodedResponse');
        return null;
      }

      final groupsData = decodedResponse['groups'];
      // print(groupsData);

      if (groupsData != null && groupsData is List) {
        final groups = groupsData
            .map<Group>((groupData) => Group.fromJson(groupData))
            .toList();
        return Groups(groups: groups);
      } else {
        print('Events data not found in response');
        return null;
      }
    } catch (e) {
      print('Error fetching $type groups: $e');
      return null;
    }
  }

  Future<void> sendRequest(String groupId) async {
    try {
      final response = await client.post('/notification', {"groupId": groupId});
      var responseData = response['message'];
      return responseData;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addParticipant(
      String groupId, List<Map<String, String>> participants) async {
    try {
      final response = await client.post(
          '/participants', {"groupId": groupId, "participants": participants});
      var responseData = response['message'];
      return responseData;
    } catch (e) {
      print(e.toString());
    }
  }
}
