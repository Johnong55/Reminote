import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Online/Friends.dart';

class FriendRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userID => _auth.currentUser?.uid;

  Future<void> addFriend(Friend friend) async {
    try {
      if (userID == null) throw Exception("User hasn't logged in");

      await _firestore
          .collection("users")
          .doc(userID)
          .collection("Friends")
          .add(friend.toMap());
    } catch (e) {
      log("Error adding friend: $e");
    }
  }

  Future<List<Friend>> getListFriends() async {
    try {
      if (userID == null) throw Exception("User hasn't logged in");

      final snapshot =
          await _firestore
              .collection("users")
              .doc(userID)
              .collection("Friends")
              .get();

      return snapshot.docs.map((doc) {
        return Friend.fromMap(doc.data());
      }).toList();
    } catch (e) {
      log("Error getting friends list: $e");
      return [];
    }
  }
  
}
