// ChatMessage.dart
class ChatMessage {
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;
  bool isSeen;
  final String? messageId; // Add message ID for easier updates

  ChatMessage({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
    required this.isSeen,
    this.messageId,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json, {String? messageId}) {
    return ChatMessage(
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      message: json['message'] ?? '',
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
      isSeen: json['isSeen'] ?? false, // Fix: read isSeen from JSON
      messageId: messageId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'time': time.toIso8601String(),
      'isSeen': isSeen,
    };
  }

  // Helper method to create a copy with updated values
  ChatMessage copyWith({
    String? sender,
    String? receiver,
    String? message,
    DateTime? time,
    bool? isSeen,
    String? messageId,
  }) {
    return ChatMessage(
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      message: message ?? this.message,
      time: time ?? this.time,
      isSeen: isSeen ?? this.isSeen,
      messageId: messageId ?? this.messageId,
    );
  }
}
