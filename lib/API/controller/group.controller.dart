// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:echirp/API/services/base_client.dart';
import 'package:http/http.dart' as http;

import '../models/group.models.dart';

class GroupController {

  Future<Groups> createGroup(
    Map<String, dynamic> requestBody) async {
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
        Uri.parse("https://e-chirp-server.vercel.app/api/groups"),
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
}
