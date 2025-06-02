// lib/Online_Repository/Chat_Repository.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseDatabase database;
  late final DatabaseReference ref;

  ChatRepository({FirebaseAuth? auth, FirebaseDatabase? database})
      : auth = auth ?? FirebaseAuth.instance,
        database = database ?? FirebaseDatabase.instance {
    final email = this.auth.currentUser?.email;
    if (email != null) {
      ref = this.database.ref("users/$email");
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<void> sendMessage(String message, User opponents) async {
    await ref.set({
      "username": opponents.email,
      "message": message,
      "time": DateTime.now().toIso8601String(),
    });
  }
  
}
