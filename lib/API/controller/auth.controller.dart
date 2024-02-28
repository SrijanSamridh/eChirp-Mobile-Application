// ignore_for_file: use_build_context_synchronously

import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/API/services/base_client.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthController {
  var client = http.Client();

  Future<User?> login(String username, String password) async {
    debugPrint('Authenticating data...');
    var body = {'username': username, 'password': password};

    try {
      // make Post request
      Map<String, dynamic> responseData =
          await BaseClient().post('auth/signin/', body);

      // Check if the user key exists in the response
      if (responseData.containsKey('user')) {
        Map<String, dynamic> userData = responseData['user'];

        // Access user data
        User user = User(
            message: responseData['message'],
            user: UserClass(
              id: userData['_id'],
              username: userData['username'],
              email: userData['email'],
              token: userData['token'],
            ));

        // Use user data as needed
        return user;
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
    // Return null if an error occurs
    return null;
  }
}
