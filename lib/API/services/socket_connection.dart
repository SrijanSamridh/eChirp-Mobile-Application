// ignore_for_file: avoid_print

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

 // Dart client
class SocketConnection {

  static IO.Socket socket = IO.io(
        'http://localhost:8080',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());

  static void establishConnection() {
    socket.onConnect((_) {
      print('Socket connection Establised');
      // socket.emit('new-message', 'test');
    });

    socket.on('660f908852faf823234baf1b-new-message', (data) => print("Socket response: $data"));
    socket.onDisconnect((_) => print('disconnect'));
  }
}
