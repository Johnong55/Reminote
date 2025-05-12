import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Offine/Completions.dart';
import 'package:study_app/models/Offine/Habit.dart';
import 'package:study_app/models/Offine/Note.dart';
import 'package:study_app/models/Offine/Streak.dart';

class IsarUtil {
  static Isar ? _isar;
  static Future<Isar> getIsarInstance() async{
    if(_isar == null || !_isar!.isOpen){
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([NoteSchema,HabitSchema,CompletionsSchema,StreakSchema], directory: dir.path);

    }
    return _isar!;
  }

}
