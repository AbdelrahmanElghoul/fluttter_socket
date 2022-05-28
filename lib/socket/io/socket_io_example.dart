import 'package:flutter/material.dart';
import 'package:fluttter_socket/socket/io/socket_io.dart';

class SocketIOExampleScreen extends StatefulWidget {
  const SocketIOExampleScreen({Key? key}) : super(key: key);

  @override
  State<SocketIOExampleScreen> createState() => _SocketIOExampleScreenState();
}

class _SocketIOExampleScreenState extends State<SocketIOExampleScreen> {
  SocketIO<String>? socket;
  @override
  void initState() {
    // was made using ngrok
    socket = SocketIO<String>('https://106b-195-37-104-54.eu.ngrok.io')
      ..connect();
    super.initState();
  }

  @override
  void dispose() {
    socket?.dispose();
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
            child: StreamBuilder<String>(
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
