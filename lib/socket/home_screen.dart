import 'package:flutter/material.dart';
import 'package:fluttter_socket/socket/io/socket_io_example.dart';
import 'package:fluttter_socket/socket/web_socket/web_socket_example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SocketIOExampleScreen(),
            WebSocketExampleScreen(),
          ],
        ),
      ),
    );
  }
}
