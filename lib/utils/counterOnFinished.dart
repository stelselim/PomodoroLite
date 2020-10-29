import 'package:flutter/material.dart';
import 'package:pomodorolite/notifications/notifications.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:pomodorolite/utils/statistics.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> counterOnFinished(BuildContext context) async {
  /// get current pomodoro settings
  final pomodoroSettings =
      Provider.of<AppState>(context, listen: false).pomodoroSettings;
  Provider.of<AppState>(context, listen: false)
      .setPomodoro(pomodoroSettings.copyWith(
    isWorkTime: false,
  ));

  /// add one current Round
  final currentRound =
      Provider.of<AppState>(context, listen: false).currentRound + 1;
  Provider.of<AppState>(context, listen: false).setCurrentRound(currentRound);

  // Print
  print("Counter Finished");
  print("current Round: $currentRound");

  /// Notification
  if (!kIsWeb) {
    workFinishedNotification();
  }

  /// Save To Local => Work Time
  await savePomodoroStatisticTime(pomodoroSettings);

  await Future.delayed(Duration(milliseconds: 240));
}

Future<void> breakCounterFinished(BuildContext context) async {
  print("Break Finished");

  /// Notification
  if (!kIsWeb) {
    breakFinishedNotification();
  }

  final pomodoroSettings =
      Provider.of<AppState>(context, listen: false).pomodoroSettings;
  Provider.of<AppState>(context, listen: false)
      .setPomodoro(pomodoroSettings.copyWith(
    isWorkTime: true,
  ));
  await Future.delayed(Duration(milliseconds: 240));
}
