// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/group.models.dart';
import '../models/message.models.dart';
import '../services/api_client.dart';
import '../services/socket_connection.dart';

class ChatController {
  Future<void> sendMessage(
      String message, String groupId, List<Participant>? participants) async {
    var body = {"groupId": groupId, "message": message};

    var response = await ApiClient().post('/message', body);
    var result = response['message'];
    print("result : $result");
    result["participants"] = participants;
    SocketConnection.socket.emit("new-message", result);
    // No setState() method is available here. You need to handle state changes in the widget tree.
  }

  Future<List<MessageElement>?> fetchMessages(BuildContext context, String groupId) async {
    try {
      var response = await ApiClient().get(context, '/message/$groupId');
      final decodedResponse = json.decode(response);

      if (decodedResponse is! Map<String, dynamic>) {
        debugPrint('Unexpected response format: $decodedResponse');
        return null;
      }
      final messagesData = decodedResponse['messages'];
      print("List of Messages : $messagesData");

      if (messagesData != null && messagesData is List) {
        final messages = messagesData
            .map<MessageElement>(
                (messageData) => MessageElement.fromJson(messageData))
            .toList();
        return messages;
      } else {
        debugPrint('Events data not found in response');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // You can't use setState() method directly in the controller.
  // You should handle state changes in the widget tree where you call this method.
  // Future<void> getMessages() async {
  //   var data = await fetchMessages(widget.id);
  //   setState(() {
  //     _messages = data;
  //   });
  // }
}
