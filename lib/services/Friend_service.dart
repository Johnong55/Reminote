import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_app/Online_Repository/Friend_Repository.dart';
import 'package:study_app/models/Online/Friends.dart';

class FriendService {
  final FriendRepository _friendRepository = FriendRepository();

  Future<void> sendFriendRequest(String friendUID, String email, String? name) async {
    final friend = Friend(
      uid: friendUID,
      email: email,
      displayName: name,
    );

    await _friendRepository.addFriend(friend);
  }

  Future<List<Friend>> fetchFriends() async {
    return await _friendRepository.getListFriends();
  }

}
