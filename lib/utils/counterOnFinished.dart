import 'package:flutter/material.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:provider/provider.dart';

Future counterOnFinished(BuildContext context) async {
  print("Counter Finished");

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

Future breakCounterFinished(BuildContext context) async {
  print("Break Finished");
  final pomodoroSettings =
      Provider.of<AppState>(context, listen: false).pomodoroSettings;
  Provider.of<AppState>(context, listen: false)
      .setPomodoro(pomodoroSettings.copyWith(
    isWorkTime: true,
  ));
  await Future.delayed(Duration(milliseconds: 240));
}
