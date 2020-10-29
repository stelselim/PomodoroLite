import 'package:pomodorolite/classes/pomodoro.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePomodoroStatisticTime(Pomodoro toAddPomodoro) async {
  final instance = await SharedPreferences.getInstance();
  final today = DateTime.now();
  final todayKey = today.month.toString() +
      "-" +
      today.day.toString() +
      "-" +
      today.year.toString();

  final todayWork =
      await getPomodoroStatisticsToday() + toAddPomodoro.workSessionMinute;
  await instance.setInt(todayKey, todayWork);
}

Future<int> getPomodoroStatisticsToday() async {
  final instance = await SharedPreferences.getInstance();
  final today = DateTime.now();
  final todayKey = today.month.toString() +
      "-" +
      today.day.toString() +
      "-" +
      today.year.toString();
  final todayStatisticsTime = instance.getInt(todayKey);
  if (todayStatisticsTime == null) {
    return 0;
  } else {
    return todayStatisticsTime;
  }
}

Future<int> getPomodoroStatisticsYesterday() async {
  final instance = await SharedPreferences.getInstance();
  final yesterday = DateTime.now().subtract(Duration(days: 1));
  final yesterdayKey = yesterday.month.toString() +
      "-" +
      yesterday.day.toString() +
      "-" +
      yesterday.year.toString();
  final yesterdayStatisticsTime = instance.getInt(yesterdayKey);
  if (yesterdayStatisticsTime == null) {
    return 0;
  } else {
    return yesterdayStatisticsTime;
  }
}

Future<List<int>> getPomodoroStatisticsWithLastTenDays() async {
  final instance = await SharedPreferences.getInstance();
  List<int> days = [];

  for (int i = 0; i < 10; i++) {
    final today = DateTime.now().subtract(Duration(days: i));
    final todayKey = today.month.toString() +
        "-" +
        today.day.toString() +
        "-" +
        today.year.toString();
    final todayStatisticsTime = instance.getInt(todayKey);

    /// IF No Study
    if (todayStatisticsTime == null) {
      days.add(0);
      await instance.setInt(todayKey, 0);
    } else {
      days.add(todayStatisticsTime);
    }
  }

  return days;
}
