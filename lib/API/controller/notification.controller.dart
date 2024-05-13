// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../models/notification.model.dart';
import '../services/base_client.dart';

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
  Future<Notifications?> fetchNotifications() async {
    try {
      var response = await BaseClient().get('/notification');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }

      if (decodedResponse.isNotEmpty ||
          decodedResponse['notifications'].length != 0) {
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
