
// ChatRepository.dart
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseDatabase database;

  ChatRepository({FirebaseAuth? auth, FirebaseDatabase? database})
    : auth = auth ?? FirebaseAuth.instance,
      database = database ?? FirebaseDatabase.instance;

  String _getChatId(String UID1, String UID2) {
    final sorted = [UID1, UID2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  DatabaseReference _chatRefWith(Friend otherUser) {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");

    final chatId = _getChatId(me.uid, otherUser.uid);
    return database.ref('chats/$chatId');
  }

  Future<void> sendMessage(String message, Friend otherUser) async {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");

    final ref = _chatRefWith(otherUser).push();
    await ref.set({
      'sender': me.email,
      'receiver': otherUser.email, // Fix: consistent field name
      'message': message,
      'time': DateTime.now().toIso8601String(),
      'isSeen': false,
    });
  }

  Stream<DatabaseEvent> streamMessages(Friend otherUser) {
    final ref = _chatRefWith(otherUser);
    return ref.orderByChild('time').onValue;
  }

  Future<List<ChatMessage>> getMessagesOnce(Friend otherUser) async {
    final ref = _chatRefWith(otherUser);
    final snapshot = await ref.get();

    if (!snapshot.exists) return [];

    final messages = <ChatMessage>[];
    for (final child in snapshot.children) {
      final data = Map<String, dynamic>.from(child.value as Map);
      final message = ChatMessage.fromJson(data, messageId: child.key);
      messages.add(message);
    }

    // Sort by time
    messages.sort((a, b) => a.time.compareTo(b.time));
    return messages;
  }

  Future<void> deleteMessage(Friend otherUser, String messageId) async {
    final ref = _chatRefWith(otherUser).child(messageId);
    await ref.remove();
  }

  Future<void> updateMessage(
    Friend otherUser,
    String messageId,
    String newMessage,
  ) async {
    final ref = _chatRefWith(otherUser).child(messageId);
    await ref.update({'message': newMessage});
  }

  // Fixed implementation of setSeenMessage
  Future<void> markMessagesAsSeen(List<ChatMessage> messages, Friend otherUser) async {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");
    log("size of messages : ${messages.length}");
    final batch = <Future>[];
    
    for (final message in messages) {
      // Only mark messages as seen if:
      // 1. The current user is the receiver
      // 2. The message is not already seen
      if (message.receiver == me.email && !message.isSeen && message.messageId != null) {
        final ref = _chatRefWith(otherUser).child(message.messageId!);
        batch.add(ref.update({'isSeen': true}));
      }
    }

    if (batch.isNotEmpty) {
      await Future.wait(batch);
    }
  }

  // Alternative: Mark a single message as seen
  Future<void> markMessageAsSeen(Friend otherUser, String messageId) async {
    final ref = _chatRefWith(otherUser).child(messageId);
    await ref.update({'isSeen': true});
  }

  // Get unread message count
  Future<int> getUnreadMessageCount(Friend otherUser) async {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");

    final messages = await getMessagesOnce(otherUser);
    return messages.where((msg) => 
      msg.receiver == me.email && !msg.isSeen
    ).length;
  }

  // Stream messages as ChatMessage objects
  Stream<List<ChatMessage>> streamChatMessages(Friend otherUser) {
    return streamMessages(otherUser).map((event) {
      if (!event.snapshot.exists) return <ChatMessage>[];

      final messages = <ChatMessage>[];
      for (final child in event.snapshot.children) {
        final data = Map<String, dynamic>.from(child.value as Map);
        final message = ChatMessage.fromJson(data, messageId: child.key);
        messages.add(message);
      }

      messages.sort((a, b) => a.time.compareTo(b.time));
      return messages;
    });
  }
}
