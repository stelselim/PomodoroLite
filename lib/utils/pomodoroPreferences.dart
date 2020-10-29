import 'package:flutter/material.dart';
import 'package:pomodorolite/classes/pomodoro.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pomodoroPreferenceKey = "PomodoroPreferences";

Future<void> savePomodoroPreferences(Pomodoro pomodoro) async {
  final instance = await SharedPreferences.getInstance();
  final toSave = pomodoro.toJson();

  await instance.setString(pomodoroPreferenceKey, toSave);
  // print("Saved: " +toSave);
}

Future<Pomodoro> getPomodoroPreferences() async {
  final instance = await SharedPreferences.getInstance();
  final preferences = instance.getString(pomodoroPreferenceKey);

  /// IF There is no configuration save initial to SharedPreferences
  if (preferences == null) {
    print("Not Found, Then Save it");
    await savePomodoroPreferences(Pomodoro());
    return Pomodoro();
  }

  final pomodoro = Pomodoro.fromJson(preferences);
  return pomodoro;
}

Future<bool> getLocalSettings(BuildContext context) async {
  final pomd = await getPomodoroPreferences();
  await Provider.of<AppState>(context, listen: false).setPomodoro(pomd);
  return true;
}
