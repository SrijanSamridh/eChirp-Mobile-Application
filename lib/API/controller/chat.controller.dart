import '../services/base_client.dart';
import '../services/socket_connection.dart';

class ChatController{
  Future<void> sendMessage(String message) async {
    var body = {"groupId": widget.id, "message": message};

    var response = await BaseClient().post('/message', body);
    var result = response['message'];
    print("result : $result");
    result["participants"] = widget.participants;
    SocketConnection.socket.emit(
      "new-message", result
    );
    setState(() {
      _messages.add(MessageElement.fromJson(result));
    });
    _controller.clear();
  }


  Future<dynamic> fetchMessages(String groupId) async {
    try {
      var response = await BaseClient().get('/message/$groupId');
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
    }
  }

  Future<void> getMessages() async {
    var data = await fetchMessages(widget.id);
    setState(() {
      _messages = data;
    });
}