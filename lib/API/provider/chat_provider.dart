import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/models/message.models.dart';
import '../../API/services/api_client.dart';
import '../../API/services/socket_connection.dart';
import '../models/group.models.dart';

class ChatProvider extends ChangeNotifier {
  late List<MessageElement> _messages = [];

  List<MessageElement> get messages => _messages;

  Future<void> sendMessage(
      String message, String groupId, List<Participant>? participants) async {
    var body = {"groupId": groupId, "message": message};

    var response = await ApiClient().post('/message', body);
    var result = response['message'];
    result["participants"] = participants;
    SocketConnection.socket.emit("new-message", result);
    // ignore: avoid_print
    print("result: $result");
    _messages.add(MessageElement.fromJson(result));
    notifyListeners();
  }

  Future<void> fetchMessages(String groupId) async {
    try {
      var response = await ApiClient().get('/message/$groupId');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return;
      }

      final messagesData = decodedResponse['messages'];

      if (messagesData != null && messagesData is List) {
        final messages = messagesData
            .map<MessageElement>(
                (messageData) => MessageElement.fromJson(messageData))
            .toList();
        _messages = messages;
        notifyListeners();
      } else {
        debugPrint('Events data not found in response');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listenToSocketEvents(dynamic data) {
    MessageElement messageElement = MessageElement.fromJson(data);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: "basic_channel",
            title: "Message from ${messageElement.user?.username}",
            body: "${messageElement.message}"));
    _messages.add(messageElement);
    notifyListeners();
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('_id');
    return userId;
  }
}
