import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class User_repository{
  static late Isar _isar;
  Future<void> initializeIsar() async{
    final dir =  await getApplicationDocumentsDirectory();
 
  }
}