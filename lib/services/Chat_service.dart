import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Online_Repository/Chat_Repository.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';

class ChatService {
  final ChatRepository repository;

  ChatService({required this.repository});

  Future<void> sendMessageTo(Friend receiver, String message) async {
    try {
      if (message.trim().isEmpty) {
        throw Exception("Message cannot be empty");
      }

      await repository.sendMessage(message, receiver);
    } catch (e) {
      rethrow;
    }
  }

  // ✅ PHƯƠNG THỨC MỚI - ĐÚNG
  Stream<List<ChatMessage>> streamMessagesWith(Friend otherUser) {
    // repository.streamChatMessages() đã trả về Stream<List<ChatMessage>>

    return repository.streamChatMessages(otherUser);
  }

  // ✅ PHƯƠNG THỨC MỚI - ĐƠN GIẢN HÓA
  Future<List<ChatMessage>> loadMessagesOnce(Friend otherUser) async {
    // repository.getMessagesOnce() đã trả về List<ChatMessage>
    return await repository.getMessagesOnce(otherUser);
  }

  Future<void> deleteMessage(Friend otherUser, String messageId) async {
    try {
      await repository.deleteMessage(otherUser, messageId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editMessage(Friend otherUser, String messageId, String newContent) async {
    try {
      if (newContent.trim().isEmpty) {
        throw Exception("New message content cannot be empty");
      }
      await repository.updateMessage(otherUser, messageId, newContent);
    } catch (e) {
      rethrow;
    }
  }

  // ✅ THÊM CÁC PHƯƠNG THỨC HỮU ÍCH
  Future<void> markMessagesAsSeen(List<ChatMessage> messages, Friend otherUser) async {
    try {
      log("start mark seen");
      await repository.markMessagesAsSeen(messages, otherUser);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markSingleMessageAsSeen(Friend otherUser, String messageId) async {
    try {
      await repository.markMessageAsSeen(otherUser, messageId);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getUnreadCount(Friend otherUser) async {
    try {
      return await repository.getUnreadMessageCount(otherUser);
    } catch (e) {
      rethrow;
    }
  }

  // Kiểm tra xem tin nhắn có phải của mình không
  bool isMyMessage(ChatMessage message) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null && message.sender == currentUser.email;
  }

  // Lấy tin nhắn chưa đọc
  List<ChatMessage> getUnreadMessages(List<ChatMessage> messages) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];
    
    return messages.where((message) => 
      message.receiver == currentUser.email && !message.isSeen
    ).toList();
  }

  // Format thời gian hiển thị
  String formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

}