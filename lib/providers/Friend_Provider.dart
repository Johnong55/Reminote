import 'package:flutter/foundation.dart';
import 'package:study_app/models/Online/Friends.dart';
import 'package:study_app/services/Friend_service.dart';

class FriendProvider extends ChangeNotifier {
  final FriendService friendService;
  final List<Friend> friends = [];
  bool isLoading = false;
  String? error;
  FriendProvider({required this.friendService}) {
    QueryFriends();
  }
  Future<void> QueryFriends() async {
    List<Friend> queries = await friendService.fetchFriends();
    attachFriends(queries);
    notifyListeners();
  }

  void attachFriends(List<Friend> query) {
    friends.clear();
    friends.addAll(query);
  }

  Future<void> addFriend(Friend friend) async {
    friendService.sendFriendRequest(
      friend.uid,
      friend.email!,
      friend.displayName,
    );
    friends.add(friend);
    
    notifyListeners();
  }

}
