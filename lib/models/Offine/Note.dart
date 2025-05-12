import 'package:isar/isar.dart';

part 'Note.g.dart'; // bat buoc ten Note phai giong ten file

@collection
class Note {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  String? ID;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  @Index()
  bool? isPinned;
  String? category;
  String? color;
  String? syncStatus;
  String? userEmail;

  Note({this.title, this.content, this.createdAt, this.updatedAt, this.isPinned, this.category, this.color,this.userEmail,this.ID});
  
    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Note) return false;
    return title == other.title && content == other.content;
  }

  // Override `hashCode` để đảm bảo tính nhất quán
  // sử dụng hashcode để so sánh cấc đối tượng đựa trên các title và content
  @override
  int get hashCode => Object.hash(title, content);
}