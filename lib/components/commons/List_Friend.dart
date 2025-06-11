import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_app/Page/Screens/ChatPage.dart';
import 'package:study_app/models/Online/ChatMessage.dart';
import 'package:study_app/models/Online/Friends.dart';
import 'package:study_app/providers/Chat_Provider.dart';

class ListFriend extends StatelessWidget {
  final List<Friend> friends;
  
  const ListFriend({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Check if user is logged in first
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || currentUser.email == null || currentUser.email!.isEmpty) {
      return const Center(
        child: Text(
          "PLEASE LOGIN TO UNLOCK THIS FUNCTION",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }
    else{
       return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return _buildFriendTile(context, friend, isDarkMode);
      },
    );
    }
   
  }

  Widget _buildFriendTile(BuildContext context, Friend friend, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode 
            ? [Colors.grey[800]!, Colors.grey[850]!]
            : [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToChatPage(friend, context),
          onLongPress: () => _showFriendOptions(context, friend),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    Hero(
                      tag: 'avatar_${friend.displayName}',
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue[400]!,
                              Colors.blue[600]!,
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue[100],
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/png/account.png",
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Text(
                                  friend.displayName != null && friend.displayName!.isNotEmpty
                                    ? friend.displayName![0].toUpperCase()
                                    : 'U',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Online status indicator
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getOnlineStatus(friend) ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDarkMode ? Colors.grey[800]! : Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(width: 16),
                
                // Friend info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name with typing indicator
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              friend.displayName ?? 'Unknown User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_isTyping(friend))
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'đang gõ...',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Last message
                      Row(
                        children: [
                          if (_getLastMessage(friend).sender == FirebaseAuth.instance.currentUser!.email)
                            Icon(
                              Icons.done_all,
                              size: 14,
                              color: _getLastMessage(friend).isSeen 
                                ? Colors.blue 
                                : Colors.grey,
                            ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _getLastMessageText(friend),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: _hasUnreadMessages(friend) 
                                  ? FontWeight.w500 
                                  : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Time and badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Time
                    Text(
                      _formatTime(_getLastMessage(friend).time),
                      style: TextStyle(
                        fontSize: 11,
                        color: _hasUnreadMessages(friend) 
                          ? Colors.blue[600]
                          : Colors.grey[500],
                        fontWeight: _hasUnreadMessages(friend) 
                          ? FontWeight.w600 
                          : FontWeight.normal,
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Unread count badge
                    if (_getUnreadCount(friend) > 0)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[500]!, Colors.blue[700]!],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          _getUnreadCount(friend) > 99 
                            ? '99+' 
                            : _getUnreadCount(friend).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
                    // Muted indicator
                    if (_isMuted(friend))
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.volume_off,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToChatPage(Friend friend, BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    
    // Set current friend in chat provider
    chatProvider.setOpponent(friend);
    
    Navigator.pushNamed(
      context,
      '/chat'
   
    );
  }

  void _showFriendOptions(BuildContext context, Friend friend) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              
              // Friend info
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Text(
                      friend.displayName != null && friend.displayName!.isNotEmpty
                        ? friend.displayName![0].toUpperCase()
                        : 'U',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    friend.displayName ?? 'Unknown User',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Options
              _buildOption(
                context,
                Icons.chat_bubble_outline,
                'Nhắn tin',
                () {
                  Navigator.pop(context);
                  _navigateToChatPage(friend, context);
                },
                isDarkMode,
              ),
              _buildOption(
                context,
                Icons.volume_off_outlined,
                _isMuted(friend) ? 'Bỏ tắt tiếng' : 'Tắt tiếng',
                () {
                  Navigator.pop(context);
                  // TODO: Toggle mute functionality
                },
                isDarkMode,
              ),
              _buildOption(
                context,
                Icons.person_outline,
                'Xem thông tin',
                () {
                  Navigator.pop(context);
                  // TODO: View profile functionality
                },
                isDarkMode,
              ),
              _buildOption(
                context,
                Icons.block_outlined,
                'Chặn người dùng',
                () {
                  Navigator.pop(context);
                  // TODO: Block user functionality
                },
                isDarkMode,
                isDestructive: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
    BuildContext context,
    IconData icon, 
    String title, 
    VoidCallback onTap,
    bool isDarkMode,
    {bool isDestructive = false}
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive 
          ? Colors.red 
          : (isDarkMode ? Colors.grey[300] : Colors.grey[700]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive 
            ? Colors.red 
            : (isDarkMode ? Colors.white : Colors.black87),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // Helper methods - you need to implement based on your data model
  bool _getOnlineStatus(Friend friend) {
    // TODO: Return online status from friend model
    return true; // Placeholder
  }

  bool _isTyping(Friend friend) {
    // TODO: Check if friend is typing
    return false; // Placeholder
  }

  ChatMessage _getLastMessage(Friend friend) {
    // TODO: Get last message from chat history
    return ChatMessage(
      message: "Hello! How are you?",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      sender: FirebaseAuth.instance.currentUser!.email ?? "unknown",
      isSeen: true,
      receiver: friend.email ?? "",
    ); // Placeholder
  }

  String _getLastMessageText(Friend friend) {
    final message = _getLastMessage(friend);
    if (message.message.length > 30) {
      return '${message.message.substring(0, 30)}...';
    }
    return message.message;
  }

  bool _hasUnreadMessages(Friend friend) {
    return _getUnreadCount(friend) > 0;
  }

  int _getUnreadCount(Friend friend) {
    // TODO: Get unread message count
    return 3; // Placeholder
  }

  bool _isMuted(Friend friend) {
    // TODO: Check if conversation is muted
    return false; // Placeholder
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Vừa xong';
    }
  }
}