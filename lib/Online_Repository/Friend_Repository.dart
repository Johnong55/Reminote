import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/models/Online/Friends.dart';

class FriendRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _myUid => _auth.currentUser?.uid;

  /// Thêm bạn – đồng bộ vào Friends của cả hai người.
  Future<void> addFriend(Friend friend) async {
    try {
      if (_myUid == null) throw Exception('User has not logged in');
      if (friend.uid.isEmpty) throw Exception('Friend.uid is empty');

      final myUid = _myUid!;
      final friendUid =await  findByEmail(friend.email!);
      friend.uid = friendUid;
      log("friendUID  : ${friendUid}");

      // Lấy thông tin người hiện tại để ghi ngược lại cho bạn
      final me = _auth.currentUser!;
      final myProfileForFriend = {
          'email': me.email,
          'userName': me.displayName,
          'userID': me.uid,
      };

      // Batch bảo đảm hai ghi cùng lúc
      final batch = _firestore.batch();

      // 1️⃣ currentUser ➜ Friends/{friendUid}
      final myFriendDoc = _firestore
          .collection('users')
          .doc(myUid)
          .collection('Friends')
          .doc(friendUid);
      batch.set(myFriendDoc, friend.toMap(), SetOptions(merge: true));

      // 2️⃣ friend ➜ Friends/{myUid}
      final friendDoc = _firestore
          .collection('users')
          .doc(friendUid)
          .collection('Friends')
          .doc(myUid);
      batch.set(friendDoc, myProfileForFriend, SetOptions(merge: true));

      await batch.commit();
      log('Friend added for both sides');
    } catch (e, s) {
      log('Error adding friend: $e\n$s');
      rethrow;
    }
  }

  /// Lấy danh sách bạn của mình
  Future<List<Friend>> getListFriends() async {
    try {
      if (_myUid == null) throw Exception('User has not logged in');

      final snapshot =
          await _firestore
              .collection('users')
              .doc(_myUid)
              .collection('Friends')
              .get();

      return snapshot.docs.map((doc) {
        // Bảo đảm uid luôn có (doc.id)
        final data = {...doc.data(), 'uid': doc.id};
        return Friend.fromMap(data);
      }).toList();
    } catch (e, s) {
      log('Error getting friends list: $e\n$s');
      return [];
    }
  }
  Future<String> findByEmail(String email) async{
    final snapshot = await FirebaseFirestore.instance
    .collection("users")
    .where('email',isEqualTo: email)
    .get();
      if(snapshot.docs.isNotEmpty)
      {
        return snapshot.docs.first.id;
      }
      return '';
  }
}
