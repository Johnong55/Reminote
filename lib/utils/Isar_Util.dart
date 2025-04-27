import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_app/models/Habit.dart';
import 'package:study_app/models/Note.dart';

class IsarUtil {
  static Isar ? _isar;
  static Future<Isar> getIsarInstance() async{
    if(_isar == null || !_isar!.isOpen){
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([NoteSchema,HabitSchema], directory: dir.path);

    }
    return _isar!;
  }

}
