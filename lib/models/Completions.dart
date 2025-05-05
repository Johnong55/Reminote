import 'package:isar/isar.dart';


part 'Completions.g.dart';

@Collection()
class Completions{
  Id id = Isar.autoIncrement;
  int? habitID;
  @Index()
  bool? isCompleted;
  DateTime? dateCompleted;
  Completions({
    this.habitID,
    this.isCompleted,
    this.dateCompleted,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "completions : habitID =${habitID}"
    " dateCompleted = ${dateCompleted}"
    " isCompleted = ${isCompleted}";
  }
}