import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../../API/controller/notification.controller.dart';
import '../../API/models/notification.model.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();
  List<NotificationElement>? _notifications = [];
  List<NotificationElement>? _lastFetchedNotifications = [];

  List<NotificationElement>? get notifications => _notifications;

  Future<void> fetchNotifications() async {
    final res = await _notificationController.fetchNotifications();
    if (res != null) {
      List<NotificationElement>? newNotifications = res.notifications;
      if (newNotifications != null && newNotifications.isNotEmpty) {
        _notifications = newNotifications;
        // Find new notifications
        List<NotificationElement> newOnes = _notifications!
            .where((notification) => !_lastFetchedNotifications!.any(
                (last) => last.notificationId == notification.notificationId))
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
        _lastFetchedNotifications = List.from(_notifications!);
      }
      notifyListeners();
    }
  }

  void listenToSocketEvents(dynamic data) {
    final newNotification = NotificationElement.fromJson(data);
    _notifications?.add(newNotification);
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: "basic_channel",
        title: "New Notification",
        body: newNotification.message,
      ),
    );
    notifyListeners();
  }

  int createUniqueId() {
    // Generate a unique ID for each notification.
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }


  Future<void> replyToNotifications(String notificationId, String reply) async {
    try{
      NotificationElement? notificationElement = await _notificationController.replyToNotifications(notificationId, reply);
      // fetchNotifications();
      notifyListeners();
    }catch (e){
      print(e.toString());
    }

  }
}
