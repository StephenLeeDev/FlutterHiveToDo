import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  IO.Socket socket = IO.io('http://192.168.1.251:3001', <String, dynamic> {
    'transports': ['websocket']
  });

  @override
  void initState() {
    super.initState();

    socket.onConnect((_) {
      debugPrint('socket connect');
      // socket.emit('newMessage', 'test');
    });
    socket.on('event', (data) => debugPrint('socket $data'));
    socket.onDisconnect((_) => debugPrint('socket disconnect'));
    socket.on('newMessage', (newMessage) => debugPrint('socket $newMessage'));

    socket.connect();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          const Text('Chat Screen'),
          IconButton(
            onPressed: () {
              // socket.emit('newMessage', 'test');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
