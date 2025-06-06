import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/components/widgets/chat_home/Message_Tile.dart';
import 'package:study_app/providers/Chat_Provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Consumer<ChatProvider>(
      builder: (context,chatProvider,child){
        if(chatProvider.isloading )
        {
          return const Center(child: CircularProgressIndicator());

        }
        return ListView.builder(
          itemCount: 10,
          
          itemBuilder: (context,index)
            {
              
            return  MessageTile(text: "hehehehe",);
          }
        );
      }
    );
  }
}