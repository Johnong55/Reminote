import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_app/models/Offine/User.dart';

class ChatPage extends StatefulWidget {
  List<User> users ;
   ChatPage({Key? key, required this.users}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _dbRef = FirebaseDatabase.instance.ref("messages");
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _dbRef.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                  return const Center(child: Text("No messages yet"));
                }

                final data = Map<dynamic, dynamic>.from(snapshot.data!.snapshot.value as dynamic);
                final messages = data.entries.map((e) => "${e.value['user']}: ${e.value['text']}").toList();

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Enter message"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = {
                      "text": _controller.text,
                      "user": "User123",
                      "timestamp": DateTime.now().millisecondsSinceEpoch,
                    };
                    _dbRef.push().set(message);
                    _controller.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
