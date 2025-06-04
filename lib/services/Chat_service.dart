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
      rethrow; // hoặc handle/log 
    }
  }

  Stream<List<ChatMessage>> streamMessagesWith(Friend otherUser) {
    return repository.streamMessages(otherUser).map((event) {
      final snapshot = event.snapshot;
      final messages = snapshot.children.map((child) {
        final data = Map<String, dynamic>.from(child.value as Map);
        return ChatMessage.fromJson(data);
      }).toList();
      return messages;
    });
  }

  Future<List<ChatMessage>> loadMessagesOnce(Friend otherUser) async {
    final rawMessages = await repository.getMessagesOnce(otherUser);
    return rawMessages.map((json) => ChatMessage.fromJson(json)).toList();
  }

  Future<void> deleteMessage(Friend otherUser, String messageId) async {
    await repository.deleteMessage(otherUser, messageId);
  }

  Future<void> editMessage(Friend otherUser, String messageId, String newContent) async {
    await repository.updateMessage(otherUser, messageId, newContent);
  }
}
