import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

// socket IO
/// listening to socket with http protocol
class SocketIO<T> {
  final String _tag = "socket";
  late StreamController<T> _streamController;
  late IO.Socket _socket;

  Stream<T> get listen => _streamController.stream;

  SocketIO(String path) {
    initSocket(path);
    _streamController = StreamController<T>.broadcast();
  }

  /// creating socket
  void initSocket(String path) {
    _socket = IO.io(
      path,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .disableAutoConnect() // disable auto-connection
          .build(),
    );
  }

  /// start listening to socket
  void connect() {
    _socket.connect();
    _socket.onConnect((data) {
      _socket.emit('msg', 'connection started at ${DateTime.now()}');
      startListening();
    });
  }

  /// handling stream listener
  /// separated stream was created for easier control
  /// and generic type in case expecting certain data type
  /// if data type doesn't match stream wont emit it
  void startListening() {
    _socket.on('event', (data) {
      if (data is T) {
        _streamController.add(data);
      } else {
        log('''\n
########################################################################
#     Listening to Unsupported type ${data.runtimeType} -> $data
########################################################################
        ''');
      }
    });
  }

  void reconnect() {
    _socket.io
      ..disconnect()
      ..connect(); // Reconnect the socket manually.
  }

  void setHeaders(String key, dynamic value) {
    _socket.io.options[key] = value; // Update the extra headers.
  }

  void onDisconnect() {
    _socket.disconnect();
  }

  void dispose() {
    if (!_socket.disconnected) onDisconnect();

    _streamController.close();
    _socket.dispose();
  }
}
