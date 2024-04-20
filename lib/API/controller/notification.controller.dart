// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/notification.model.dart';
import '../services/base_client.dart';

class NotificationController {
  Future<Notifications?> fetchNotifications() async {
    try {
      var response = await BaseClient().get('/notification');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }

      if (decodedResponse.isNotEmpty || decodedResponse['notifications'].length != 0) {
        final notifications = Notifications.fromRawJson(response);
        print(notifications.notifications);
        return notifications;
      } else {
        debugPrint('No notification to show.');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
      return null;
    }
  }
}
