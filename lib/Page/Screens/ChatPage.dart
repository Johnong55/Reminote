import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/widgets/chat_home/Message_List.dart';

import 'package:study_app/providers/Chat_Provider.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatProvider chatProvider = Provider.of<ChatProvider>(context,listen: false);
  
    final TextEditingController _messageController = TextEditingController();
  List<String> messages = []; // Danh sách tin nhắn

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
        chatProvider.sendMessage(text);
        
      
      _messageController.clear(); // Xoá sau khi gửi
    }
  }
  @override 
  void initState()
  {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        key : const ValueKey("ChatBar"),
            title: Text(
             "${chatProvider.opponent!.displayName  }"
            ),
            actions: [
              IconButton(onPressed: (){log("voice call");}, icon: Icon(Icons.call)),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: IconButton(onPressed: (){log("video call");}, icon:Icon(Icons.video_call_outlined,size: 30,)),
              ),

            ],

      ),
       body: Column(
        children: [
          Expanded(
            child: MessageList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      log("Bạn đang gõ: $value"); // Hiển thị mỗi khi gõ
                    },
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}