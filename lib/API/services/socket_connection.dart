// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

// Dart client
class SocketConnection {
  static IO.Socket socket = IO.io(
      'http://localhost:8080',
      // 'http://54.221.29.4:8080',
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
    print("==============================================$userId");
    socket.on('$userId-new-message', (data) {
      print("Socket response: $data");

      return data;
    });
    // _messages.add(MessageElement.fromJson(data));
    // notifyListeners();
  }

  
}
