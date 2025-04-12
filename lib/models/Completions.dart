import 'package:isar/isar.dart';


part 'Completions.g.dart';

@Collection()
class Completions{
  Id id = Isar.autoIncrement;
  int? habitID;
  bool? allCompleted;
  DateTime? dateCompleted;
  
}