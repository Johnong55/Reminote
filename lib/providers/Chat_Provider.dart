import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';
import 'package:study_app/services/Chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final ChatService chatService;
  Friend? opponent;
  List<ChatMessage> messages = [];
  bool isloading = false;
  String? error;
  StreamSubscription<List<ChatMessage>>? _messageSubscription;

  ChatProvider({required this.chatService, this.opponent}) {
    if (opponent != null) {
      listenToMessage();
    }
  }

  void listenToMessage() {
    if (opponent == null) return;

    // Cancel previous subscription nếu có
    _messageSubscription?.cancel();

    _messageSubscription = chatService.streamMessagesWith(opponent!).listen(
      (newMessages) {
        messages = newMessages;
        
        // ✅ Mark messages as seen khi nhận được dữ liệu mới
        _markUnreadMessagesAsSeen();
        
        notifyListeners();
      },
      onError: (e) {
        error = e.toString();
        log("Stream error: $error");
        notifyListeners();
      },
    );
  }

  // ✅ Method riêng để mark messages as seen
  void _markUnreadMessagesAsSeen() async {
    if (opponent == null || messages.isEmpty) return;

    try {
      // Lấy những tin nhắn chưa đọc mà mình là receiver
      final unreadMessages = chatService.getUnreadMessages(messages);
      
      if (unreadMessages.isNotEmpty) {
        log("Marking ${unreadMessages.length} messages as seen");
        await chatService.markMessagesAsSeen(unreadMessages, opponent!);
      }
    } catch (e) {
      log("Error marking messages as seen: $e");
    }
  }

  Future<void> sendMessage(String message) async {
    if (opponent == null) return;

    try {
      await chatService.sendMessageTo(opponent!, message);
      error = null; // Clear error on success
    } catch (e) {
      error = e.toString();
      log("Send message error: $error");
      notifyListeners();
    }
  }

  Future<void> loadOnce() async {
    if (opponent == null) return;

    isloading = true;
    notifyListeners();

    try {
      messages = await chatService.loadMessagesOnce(opponent!);
      error = null;
      
      // ✅ Mark messages as seen sau khi load
      _markUnreadMessagesAsSeen();
      
    } catch (e) {
      error = e.toString();
      log("Load messages error: $error");
    }

    isloading = false;
    notifyListeners();
  }

  void setOpponent(Friend newOpponent) {
    if (opponent?.uid == newOpponent.uid) return;

    // Cancel previous subscription
    _messageSubscription?.cancel();

    opponent = newOpponent;
    messages = [];
    error = null;
    
    log("Set opponent: ${opponent?.displayName}");
    
    // Start listening to new opponent's messages
    listenToMessage();
    
    notifyListeners();
  }

  // ✅ Method để manually mark messages as seen (ví dụ khi user mở chat)
  Future<void> markCurrentMessagesAsSeen() async {
    _markUnreadMessagesAsSeen();
  }

  // ✅ Get unread count
  int get unreadCount {
    if (opponent == null) return 0;
    return chatService.getUnreadMessages(messages).length;
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }
}
