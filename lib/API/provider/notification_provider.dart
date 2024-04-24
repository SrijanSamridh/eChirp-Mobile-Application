import 'package:flutter/material.dart';
import '../../API/controller/notification.controller.dart';
import '../../API/models/notification.model.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();
  List<NotificationElement>? _notifications = [];

  List<NotificationElement>? get notifications => _notifications;

  Future<dynamic> fetchNotifications() async {
    final res = await _notificationController.fetchNotifications();
    _notifications = res!.notifications;
    notifyListeners();
  }

  void listenToSocketEvents(dynamic data) {
    _notifications?.add(NotificationElement.fromJson(data));
    notifyListeners();
  }

}
