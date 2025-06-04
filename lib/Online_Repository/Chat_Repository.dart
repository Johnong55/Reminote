import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:study_app/models/Online/Friends.dart';

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseDatabase database;

  ChatRepository({FirebaseAuth? auth, FirebaseDatabase? database})
    : auth = auth ?? FirebaseAuth.instance,
      database = database ?? FirebaseDatabase.instance;

  String _getChatId(String email1, String email2) {
    final sorted = [email1, email2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  DatabaseReference _chatRefWith(Friend otherUser) {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");

    final chatId = _getChatId(me.email!, otherUser.email!);
    return database.ref('chats/$chatId');
  }

  Future<void> sendMessage(String message, Friend otherUser) async {
    final me = auth.currentUser;
    if (me == null) throw Exception("Not logged in");

    final ref = _chatRefWith(otherUser).push();
    await ref.set({
      'sender': me.email,
      'receiver': otherUser.email,
      'message': message,
      'time': DateTime.now().toIso8601String(),
    });
  }

  Stream<DatabaseEvent> streamMessages(Friend otherUser) {
    final ref = _chatRefWith(otherUser);
    return ref.orderByChild('time').onValue;
  }

  Future<List<Map<String, dynamic>>> getMessagesOnce(Friend otherUser) async {
    final ref = _chatRefWith(otherUser);
    final snapshot = await ref.get();

    if (!snapshot.exists) return [];

    final messages = <Map<String, dynamic>>[];
    for (final child in snapshot.children) {
      final data = Map<String, dynamic>.from(child.value as Map);
      messages.add(data);
    }

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
 
}
