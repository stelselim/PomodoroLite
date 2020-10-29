import 'package:flutter/material.dart';
import 'package:pomodorolite/classes/pomodoro.dart';

class AppState with ChangeNotifier {
  int currentRound = 0;
  Pomodoro pomodoroSettings = Pomodoro();

  setPomodoro(Pomodoro updatedPomodoro) {
    if (pomodoroSettings == updatedPomodoro) return;

    pomodoroSettings = updatedPomodoro;
    notifyListeners();
  }

  setWorkTime() {
    pomodoroSettings.isWorkTime = true;
    notifyListeners();
  }

  setBreakTime() {
    pomodoroSettings.isWorkTime = false;
    notifyListeners();
  }

  setCurrentRound(int updatedCurrentRound) {
    if (currentRound == updatedCurrentRound) return;

    currentRound = updatedCurrentRound;
    notifyListeners();
  }
}
