import 'dart:developer';

import 'package:study_app/Offline_Repository/Streak_repository.dart';
import 'package:study_app/Online_Repository/Streak_Repository_Online.dart';
import 'package:study_app/models/Offine/Streak.dart';

class StreakService {
  final StreakRepository _repository = StreakRepository();
  final StreakRepositoryOnline _repositoryOnline = StreakRepositoryOnline();

  /// Initialize the local database
  Future<void> init() async {
    await _repository.initializeIsar();
  }

  /// Lấy tất cả các streak
  Future<List<Streak>> getAllStreaks() async {
    List<Streak> streaks = await _repository.getAllStreak();
    for (Streak i in streaks) {
      log(i.toString());
    }
    return streaks;
  }

  /// Lấy streak hiện tại (dựa vào ngày hôm qua)
  Future<Streak?> getCurrentStreak() async {

    return await _repository.getLastestStreak();
  }

  /// Cập nhật streak sau khi hoàn thành một thói quen hôm nay
  Future<Streak> updateStreakAfterCompletion() async {
    Streak streak = await _repository.updateStreakAfterCompletion();
    return streak;
  }

  Future<Streak> updateStreakAfterUnCompletion() async {
    return await _repository.updateStreakAfterUnCompletion();
  }

  /// Kiểm tra xem streak hiện tại có đang hoạt động không
  Future<bool> isStreakActive() async {
    return await _repository.isStreakActive();
  }

  Future<void> updateStreakIntoFireBase(Streak streak) async {
    await _repositoryOnline.addStreakToFireBase(streak);
    await _repository.saveStreak(streak);
  }

  Future<void> getStreakFromFireBase() async {
    final List<Streak> streaks = await _repositoryOnline.getStreakByUserEmail();
    streaks.forEach((streak) {
      log(streak.toString());
      _repository.saveStreak(streak);
    });

  }

  Future<void> pushStreakFromFirebase(Streak streak) async {
    await _repositoryOnline.addStreakToFireBase(streak);
  }

  Future<void> deleteStreakWhenLogOut() async {
    await _repository.deleteAllStreak();
  }
}
