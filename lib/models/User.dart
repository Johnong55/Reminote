import 'package:isar/isar.dart';

part 'User.g.dart';

@collection
class User{
  
  Id? id  = Isar.autoIncrement;
  String? name;
 
  @Index(unique: true)
  String? email;
  String? phone;
  String? password;
  String? imageUrl;
  String? token;
  int? tokenExpiration;
  int? longestStreak;
  User({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.imageUrl,
    this.token,
    this.tokenExpiration,
    this.longestStreak
  });
}