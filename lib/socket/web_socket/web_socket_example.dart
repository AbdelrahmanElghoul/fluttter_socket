import 'package:flutter/material.dart';
import 'package:fluttter_socket/socket/web_socket/web_socket.dart';

class WebSocketExampleScreen extends StatefulWidget {
  const WebSocketExampleScreen({Key? key}) : super(key: key);

  @override
  State<WebSocketExampleScreen> createState() => _WebSocketExampleScreenState();
}

class _WebSocketExampleScreenState extends State<WebSocketExampleScreen> {
  WsSocket<String>? socket;
  @override
  void initState() {
    // link made using ngrok
    socket = WsSocket<String>('ws://106b-197-37-104-54.eu.ngrok.io/ws')
      ..connect();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        title: const Text("Socket"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            child: StreamBuilder<dynamic>(
                stream: socket?.listen,
                builder: (_, data) {
                  return Text("${data.data}");
                }),
          ),
        ],
      ),
    );
  }
}
