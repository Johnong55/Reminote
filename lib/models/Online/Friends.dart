
class Friend {
   String uid;
  final String? email;
  final String? displayName;

  Friend({
    required this.uid,
    this.email,
    this.displayName,
  });

  factory Friend.fromMap(Map<String, dynamic> data) {
    return Friend(
      uid: data['userID'],
      email: data['email'],
      displayName: data['userName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': uid,
      'email': email,
      'userName': displayName,
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return "UID : ${uid} ,  emai : ${email} , displayName : ${displayName}";
  }
}
