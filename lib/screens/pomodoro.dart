import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodorolite/components/configureBottomSheet.dart';
import 'package:pomodorolite/components/counter.dart';
import 'package:pomodorolite/components/roundBar.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:pomodorolite/utils/counterOnFinished.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key key}) : super(key: key);

  static final buttonTextStyle = TextStyle(
    fontSize: 26,
    color: Colors.cyan.shade500,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    final controller = CountdownController();
    controller.pause(); // Width Pause

    return Container(
      child: Column(
        children: [
          // Counter
          Expanded(
            flex: 3,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  /// Connected to The Provider
                  Consumer<AppState>(
                    builder: (context, state, _) {
                      int durationInSeconds =
                          state.pomodoroSettings.workSessionMinute * 60;
                      int breakDurationInSeconds =
                          state.pomodoroSettings.breakMinute * 60;

                      int currentRound = state.currentRound;

                      /// Finished Countdown
                      if (currentRound == state.pomodoroSettings.rounds) {
                        // Returs Countdown because not to be memory leaks
                        return Countdown(
                          controller: controller,
                          seconds: durationInSeconds,
                          build: (BuildContext context, double time) {
                            controller.pause();

                            return CompletedCounterWidget(
                              rounds: currentRound,
                            );
                          },
                          interval: Duration(milliseconds: 100),
                        );
                      }

                      if (state.pomodoroSettings.isWorkTime) {
                        /// Work Time Counter
                        return Countdown(
                          controller: controller,
                          seconds: durationInSeconds,
                          build: (BuildContext context, double time) {
                            /// Disable when initiiazed
                            if (durationInSeconds == time) {
                              controller.pause();
                            }

                            return CounterWidget(
                              time: time,
                            );
                          },
                          interval: Duration(milliseconds: 100),
                          onFinished: () async {
                            try {
                              await counterOnFinished(context);
                              controller.restart();
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      }

                      /// Break Time Counter
                      else {
                        return Countdown(
                          controller: controller,
                          seconds: breakDurationInSeconds,
                          build: (BuildContext context, double time) {
                            /// Disable when initiiazed
                            if (breakDurationInSeconds == time) {
                              controller.pause();
                            }

                            return BreakCounterWidget(
                              time: time,
                            );
                          },
                          interval: Duration(milliseconds: 100),
                          onFinished: () async {
                            try {
                              await breakCounterFinished(context);
                              controller.restart();
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      }
                    },
                  ),

                  /// Current Round
                  Positioned(
                    child: RoundBar(),
                    bottom: 15,
                  ),
                ],
              ),
            ),
          ),

          // Resume
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                controller.resume();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Resume",
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
          // Stop
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                controller.pause();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Stop",
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
          // Restart
          Expanded(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    content: Text("Are You Sure To Restart?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("Restart This Sesion"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.restart();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("Restart All"),
                        onPressed: () async {
                          try {
                            Navigator.of(context).pop();

                            // Set Round => 0
                            Provider.of<AppState>(context, listen: false)
                                .setCurrentRound(0);

                            // Set Work Time => true
                            Provider.of<AppState>(context, listen: false)
                                .setWorkTime();

                            await Future.delayed(Duration(milliseconds: 200));
                            controller.restart();
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ],
                  ),
                  barrierDismissible: true,
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Restart",
                  style: buttonTextStyle,
                ),
              ),
            ),
          ),
          // Configure
          Expanded(
            flex: 1,
            child: FlatButton(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Configure",
                  style: buttonTextStyle.copyWith(
                    color: Colors.blueGrey.shade700,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onPressed: () async {
                try {
                  bool changes = await showConfigureBottomSheet(
                    context,
                  );

                  // Wait For Changes
                  await Future.delayed(Duration(milliseconds: 300));

                  if (changes) {
                    controller.restart();
                    controller.pause();
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
