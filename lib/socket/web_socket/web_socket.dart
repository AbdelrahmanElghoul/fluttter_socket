import 'dart:async';
import 'dart:developer';

import 'package:web_socket_channel/io.dart';

// web socket
/// listening to socket with ws protocol
class WsSocket<T> {
  final String _tag = "socket";
  late StreamController<T> _streamController;
  late IOWebSocketChannel _channel;

  Stream<T> get listen => _streamController.stream;

  WsSocket(String path) {
    initSocket(path);
    _streamController = StreamController<T>.broadcast();
  }

  void initSocket(String path) {
    _channel = IOWebSocketChannel.connect(Uri.parse(path));
  }

  void connect() {
    _channel.sink.add('connection started at ${DateTime.now()}');
  }

  void startListening() {
    _channel.stream.listen((data) {
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
}
