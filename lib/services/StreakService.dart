import 'package:study_app/Offline_Repository/Streak_repository.dart';
import 'package:study_app/models/Offine/Streak.dart';

class StreakService {
  final StreakRepository _repository =  StreakRepository();



  /// Initialize the local database
  Future<void> init() async {
    await _repository.initializeIsar();
  }

  /// Lấy tất cả các streak
  Future<List<Streak>?> getAllStreaks() async {
    return await _repository.getAllStreak();
  }

  /// Lấy streak hiện tại (dựa vào ngày hôm qua)
  Future<Streak?> getCurrentStreak() async {
    return await _repository.getLastestStreak();
  }

  /// Cập nhật streak sau khi hoàn thành một thói quen hôm nay
  Future<Streak> updateStreakAfterCompletion() async {
    return await _repository.updateStreakAfterCompletion();
  }

  /// Kiểm tra xem streak hiện tại có đang hoạt động không
  Future<bool> isStreakActive() async {
    return await _repository.isStreakActive();
  }
}
