import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:pomodorolite/utils/pomodoroPreferences.dart';
import 'package:provider/provider.dart';

/// Returns true if changed
Future<bool> showConfigureBottomSheet(
  BuildContext context,
) async {
  var pomodoro = Provider.of<AppState>(context, listen: false).pomodoroSettings;
  int rounds = pomodoro.rounds;
  int breakTime = pomodoro.breakMinute;
  int workTime = pomodoro.workSessionMinute;

  bool changed = false; // There is no change beginning

  await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.grey.shade200,
      child: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              /// Rounds
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            text: "Rounds \n",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "$rounds times",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 4,
                      child: CupertinoSlider(
                        max: 10,
                        min: 1,
                        value: rounds.toDouble(),
                        divisions: 9,
                        onChanged: (double value) {
                          setState(() {
                            rounds = value.roundToDouble().toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Work Time
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            text: "Work Session \n",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "$workTime min",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 4,
                      child: CupertinoSlider(
                        max: 60,
                        min: 1,
                        value: workTime.toDouble(),
                        divisions: 59,
                        onChanged: (double value) {
                          setState(() {
                            workTime = value.roundToDouble().toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Break Time
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: RichText(
                        text: TextSpan(
                          text: "Break Time\n",
                          style: TextStyle(
                            color: Colors.blueGrey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: "$breakTime min",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: CupertinoSlider(
                        max: 20,
                        min: 1,
                        value: breakTime.toDouble(),
                        divisions: 19,
                        onChanged: (double value) {
                          setState(() {
                            breakTime = value.roundToDouble().toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Save & Cancel Button Bar
              Expanded(
                flex: 6,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        child: Text(
                          "Don't Save",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          changed = false;
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          "Save",
                          textScaleFactor: 1.15,
                        ),
                        onPressed: () async {
                          try {
                            final tosavePomodoro = pomodoro.copyWith(
                              breakMinute: breakTime,
                              rounds: rounds,
                              workSessionMinute: workTime,
                              isWorkTime: true,
                            );

                            // Set Current Round => 0
                            Provider.of<AppState>(context, listen: false)
                                .setCurrentRound(0);

                            // Set Pomdoro Changes
                            Provider.of<AppState>(context, listen: false)
                                .setPomodoro(tosavePomodoro);

                            /// Set Pomodoro Changes Local => SharedPreferences
                            await savePomodoroPreferences(tosavePomodoro);

                            Navigator.pop(context);
                            changed = true;
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// Space Bottom
              Expanded(
                flex: 1,
                child: Container(
                    // child: FlatButton(
                    //   child: Text("gry"),
                    //   onPressed: () async {},
                    // ),
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  /// For Checking Changes
  return changed;
}
