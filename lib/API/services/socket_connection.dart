// ignore_for_file: avoid_print

import 'package:echirp/API/provider/chat_provider.dart';
import 'package:echirp/API/provider/notification_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// Dart client
class SocketConnection {
  static IO.Socket socket = IO.io(
      'http://23.23.60.2:8080',
      OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  static Future<void> establishConnection() async {
    socket.onConnect((_) {
      print('Socket connection Establised');
      // socket.emit('new-message', 'test');
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  Future<void> listenToSocketEvents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('_id');
    print(userId);
    // ignore: use_build_context_synchronously
    var chatProvider = ChatProvider();
    socket.on('$userId-new-message', (data) {
      print("Socket response: $data");
      chatProvider.listenToSocketEvents(data);
      print("\n\n\n");
      print(chatProvider.messages);
    });
    var notificationProvider = NotificationProvider();
    socket.on('$userId-new-notification', (data) {
      print("Socket response for notification: $data");
      notificationProvider.listenToSocketEvents(data);
      print("\n\n\n");
      print(notificationProvider.notifications?.first);
    });
    // _messages.add(MessageElement.fromJson(data));
    // notifyListeners();
  }
}
