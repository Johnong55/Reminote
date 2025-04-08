import 'package:isar/isar.dart';

part 'Note.g.dart'; // bat buoc ten Note phai giong ten file

@collection
class Note {
  Id id = Isar.autoIncrement;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  @Index()
  bool? isPinned;
  String? category;
  String? color;
  Note({this.title, this.content, this.createdAt, this.updatedAt, this.isPinned, this.category, this.color});
}