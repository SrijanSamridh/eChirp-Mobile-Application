// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/API/services/base_client.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthController {
  var client = http.Client();

  Future<User?> signIn(var payload) async {
    debugPrint('Authenticating data...');
    var body = payload;

    try {
      // Make the POST request
      var response = await http.post(
        Uri.parse('$baseUrl/auth/signin'),
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Check if the response has a successful status code
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        // Check if the user key exists in the response
        if (responseData.containsKey('user')) {
          Map<String, dynamic> userData = responseData['user'];

          // Access user data
          User user = User(
            message: responseData['message'],
            user: UserClass.fromJson(userData),
          );

          // Use user data as needed
          return user;
        } else {
          debugPrint('User key not found in the response.');
        }
      } else {
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, $response');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    // Return null if an error occurs
    return null;
  }

  Future<User?> signUp(BuildContext context, payload) async {
    try {
      debugPrint(payload.toString());

      // Make the POST request
      var response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        body: json.encode(payload),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response: ${response.body}');

      // Check if the response has a successful status code
      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        // Check if the user key exists in the response
        if (res.containsKey('body')) {
          Map<String, dynamic> userData = res['body'];

          // Access user data
          User user = User(
            message: res['message'],
            user: UserClass.fromJson(userData),
          );

          debugPrint('User Registered: ${user.user?.token}');
          return user;
        } else {
          debugPrint('User key not found in the response.');
        }
      } else {
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, $response');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${response.body.split('Path')[1].split('providerId')[0]} ${response.body.split('Path')[2].split('"')[0]}'),
          ),
        );
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    return null;
  }
}
