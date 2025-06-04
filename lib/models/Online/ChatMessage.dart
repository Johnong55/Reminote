class ChatMessage {
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;

  ChatMessage({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      message: json['message'] ?? '',
      time: DateTime.tryParse(json['time'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'time': time.toIso8601String(),
    };
  }
}
