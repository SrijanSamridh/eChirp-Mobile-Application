// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupController {
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('x-auth-token');
    return token ?? '';
  }

  Future<Map<String, dynamic>> createGroup(Map<String, dynamic> requestBody) async {
    // Define the API endpoint URL
    const String apiUrl = 'https://e-chirp-server.vercel.app/api/groups';

    // Get Token
    String token = await getToken();

    // Make the POST request
    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode(requestBody),
      );

      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract relevant data from the response
        String message = responseData['message'];
        Map<String, dynamic> groupData = responseData['group'];

        // Print or handle the response data
        print('Message: $message');
        print('Group ID: ${groupData['groupId']}');
        return {'message': message, 'groupData': groupData};
      } else {
        // Handle non-successful status codes
        print('Failed with status code ${response.statusCode}');
        return {'error': 'Failed with status code ${response.statusCode}'};
      }
    } catch (e) {
      // Handle errors
      print('Error creating group: $e');
      return {'error': 'Error creating group: $e'};
    }
  }
}
