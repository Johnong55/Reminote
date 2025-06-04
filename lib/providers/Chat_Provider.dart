import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';
import 'package:study_app/services/Chat_service.dart';

class ChatProvider extends ChangeNotifier  {
  final ChatService chatService;
  final Friend? opponent;
  List<ChatMessage> messages = [];
  bool isloading = false;
  String? error;
  ChatProvider({required this.chatService,  this.opponent })
  {
    listenToMessage();
    
  }
  void listenToMessage(){
    chatService.streamMessagesWith(opponent!).listen((newMessage){
      messages = newMessage;
      notifyListeners();

    }, onError: (e){
        error = e.toString();
        notifyListeners();

    });
  }
  Future<void> sendMessage(String message) async{
    try{
      await chatService.sendMessageTo(opponent!, message);

    } catch(e){
      error = e.toString();
      notifyListeners();
    }
  }
  Future<void> loadOnce() async{
    isloading = true;
    notifyListeners();
    try{
      messages = await chatService.loadMessagesOnce(opponent!);
      error = null;

    }
    catch  (e){
      error = e.toString();
    }
    isloading = false;

    notifyListeners();

  }
}