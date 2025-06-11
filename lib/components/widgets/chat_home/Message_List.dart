import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/widgets/chat_home/Message_Tile.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/providers/Chat_Provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.isloading) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ChatMessage> messages = chatProvider.messages;
        return ListView.builder(
          itemCount: messages.length,

          itemBuilder: (context, index) {
            return MessageTile(
              text: messages[index].message,
              isMe:
                  messages[index].sender ==
                          FirebaseAuth.instance.currentUser!.email
                      ? true
                      : false,
              senderName: messages[index].sender,
              isRead: messages[index].isSeen,
              timestamp: messages[index].time,

            );
          },
        );
      },
    );
  }
}
