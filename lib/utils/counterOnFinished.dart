import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodorolite/notifications/notifications.dart';
import 'package:pomodorolite/notifications/notifications_config.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:provider/provider.dart';

Future<void> counterOnFinished(BuildContext context) async {
  print("Counter Finished");

  /// Notification
  workFinishedNotification();

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

  print("current Round: $currentRound");

  await Future.delayed(Duration(milliseconds: 240));
}

Future<void> breakCounterFinished(BuildContext context) async {
  print("Break Finished");

  /// Notification
  breakFinishedNotification();

  final pomodoroSettings =
      Provider.of<AppState>(context, listen: false).pomodoroSettings;
  Provider.of<AppState>(context, listen: false)
      .setPomodoro(pomodoroSettings.copyWith(
    isWorkTime: true,
  ));
  await Future.delayed(Duration(milliseconds: 240));
}
