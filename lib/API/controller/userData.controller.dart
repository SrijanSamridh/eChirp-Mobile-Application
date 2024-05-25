import 'dart:convert';

import 'package:echirp/API/models/userData.model.dart';
import 'package:flutter/material.dart';

import '../services/api_client.dart';

class UserDataController {
  final client = ApiClient();
  Future<UserData?> fetchUserData(BuildContext context) async {
    try {
      final response = await client.get(context, "/auth");

      if (response == null || response.isEmpty) {
        debugPrint('Unexpected response format: $response');
        return null;
      }

      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      } else {
        return UserData.fromJson(decodedResponse);
      }
    } catch (e) {
      debugPrint('Error fetching events: $e');
      return null;
    }
  }
}
