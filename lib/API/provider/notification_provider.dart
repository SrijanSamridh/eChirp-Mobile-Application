import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../API/controller/notification.controller.dart';
import '../../API/models/notification.model.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();
  List<NotificationElement>? _notifications = [];
  List<NotificationElement>? _lastFetchedNotifications = [];
  int _newMessagesCount = 0;

  List<NotificationElement>? get notifications => _notifications;
  int get newMessagesCount => _newMessagesCount;

  /// Fetch notifications from the server and update the notification list.
  Future<void> fetchNotifications(BuildContext context) async {
    try {
      final res = await _notificationController.fetchNotifications(context);
      if (res != null) {
        List<NotificationElement>? newNotifications = res.notifications;
        if (newNotifications != null && newNotifications.isNotEmpty) {
          _notifications = newNotifications;

          // Trigger notifications for new ones
          triggerNewNotifications();

          // Update the last fetched notifications
          _lastFetchedNotifications = List.from(_notifications!);
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching notifications: ${e.toString()}");
    }
  }

  /// Listen to real-time socket events and handle incoming notifications.
  void listenToSocketEvents(dynamic data) {
    try {
      final newNotification = NotificationElement.fromJson(data);
      _notifications?.add(newNotification);
      _newMessagesCount++;

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: "basic_channel",
          title: "New Notification",
          body: newNotification.message,
        ),
      );
      notifyListeners();
    } catch (e) {
      print("Error handling socket event: ${e.toString()}");
    }
  }

  /// Generate a unique ID for each notification.
  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  /// Reply to a specific notification.
  Future<void> replyToNotifications(BuildContext context, String notificationId, String reply) async {
    try {
      NotificationElement? notificationElement = await _notificationController
          .replyToNotifications(notificationId, reply);
      if (notificationElement != null) {
        // Handle any additional logic if needed
        // Optionally refetch notifications or update state as needed
      }
      fetchNotifications(context);
      notifyListeners();
    } catch (e) {
      print("Error replying to notification: ${e.toString()}");
    }
  }

  /// Trigger notifications for new ones.
  void triggerNewNotifications() {
    // Find new notifications
    List<NotificationElement> newOnes = _notifications!
        .where((notification) => !_lastFetchedNotifications!
            .any((last) => last.notificationId == notification.notificationId))
        .toList();

    for (var notification in newOnes) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: "basic_channel",
          title: "New Notification",
          body: notification.message,
        ),
      );
    }

    // Update the count of new messages
    _newMessagesCount += newOnes.length;
  }
}
