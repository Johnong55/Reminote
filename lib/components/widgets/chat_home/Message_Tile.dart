import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime? timestamp;
  final String? senderName;
  final bool isRead;
  final VoidCallback? onLongPress;

  const MessageTile({
    super.key,
    required this.text,
    this.isMe = false,
    this.timestamp,
    this.senderName,
    this.isRead = true,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar cho tin nhắn của đối phương
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
              child: Text(
                senderName?.substring(0, 1).toUpperCase() ?? 'U',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          
          // Bubble tin nhắn
          Flexible(
            child: GestureDetector(
              onLongPress: onLongPress,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.primary.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMe
                      ? null
                      : isDarkMode
                          ? Colors.grey[800]
                          : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(isMe ? 20 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tên người gửi (chỉ hiện với tin nhắn của đối phương)
                      if (!isMe && senderName != null) ...[
                        Text(
                          senderName!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      
                      // Nội dung tin nhắn
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          color: isMe
                              ? Colors.white
                              : isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      
                      // Thời gian và trạng thái đọc
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _formatTime(timestamp ?? DateTime.now()),
                            style: TextStyle(
                              fontSize: 11,
                              color: isMe
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.grey[600],
                            ),
                          ),
                          
                          // Icon trạng thái đọc (chỉ cho tin nhắn của mình)
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            Icon(
                              isRead ? Icons.done_all : Icons.done,
                              size: 14,
                              color: isRead
                                  ? Colors.blue[300]
                                  : Colors.white.withOpacity(0.8),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Spacing cho tin nhắn của mình
          if (isMe) ...[
            const SizedBox(width: 8),
            // Có thể thêm avatar của mình ở đây nếu muốn
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${dateTime.day}/${dateTime.month}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Vừa xong';
    }
  }
}

// Widget mở rộng cho các loại tin nhắn đặc biệt
class ImageMessageTile extends StatelessWidget {
  final String imageUrl;
  final String? caption;
  final bool isMe;
  final DateTime? timestamp;
  final VoidCallback? onTap;

  const ImageMessageTile({
    super.key,
    required this.imageUrl,
    this.caption,
    this.isMe = false,
    this.timestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hình ảnh
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      
                      // Caption nếu có
                      if (caption != null && caption!.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          color: Colors.black.withOpacity(0.7),
                          child: Text(
                            caption!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}