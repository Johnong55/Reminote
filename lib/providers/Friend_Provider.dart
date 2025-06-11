import 'package:flutter/foundation.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';
import 'package:study_app/services/Friend_service.dart';

class FriendProvider extends ChangeNotifier {
   FriendService friendService;
   List<Friend> friends = [];
  late  Map<Friend,ChatMessage> lastMessage;
  
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
