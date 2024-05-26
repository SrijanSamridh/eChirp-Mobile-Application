// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../models/notification.model.dart';
import '../services/api_client.dart';
import 'package:http/http.dart' as http;

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  // API calls here below
  Future<Notifications?> fetchNotifications(BuildContext context) async {
    try {
      var response = await ApiClient().get(context, '/notification');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }

      if (decodedResponse.isNotEmpty ||
          decodedResponse['notifications'].length != 0) {
        final notifications = Notifications.fromRawJson(response);
        print(decodedResponse);
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

  Future<NotificationElement?> replyToNotifications(
      String notificationId, String reply) async {
    // Get Token
    String token = await ApiClient().getToken();

    try {
      var uri =
          Uri.parse("$baseUrl/notification/"); // Assuming your API endpoint
      var response = await http.put(
        uri,
        body: jsonEncode({"notificationId": notificationId, "reply": reply}),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        if (decodedResponse is! Map<String, dynamic>) {
          debugPrint('Unexpected response format: $decodedResponse');
          return null;
        }

        if (decodedResponse.containsKey('notification')) {
          final notification =
              NotificationElement.fromJson(decodedResponse['notification']);
          print(decodedResponse);
          return notification;
        } else {
          debugPrint('No notification to show.');
          return null;
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error replying to notifications: $e');
      return null;
    }
  }
}
