import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodorolite/components/counter.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key key}) : super(key: key);

  static const buttonTextStyle = TextStyle(
    fontSize: 26,
    color: Colors.indigo,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    final controller = CountdownController();
    controller.pause(); // Width Pause

    int durationMinute = 10;
    int dur = durationMinute * 60;

    return Container(
      child: Column(
        children: [
          // Counter
          Expanded(
            flex: 3,
            child: Center(
              child: Countdown(
                controller: controller,
                seconds: dur,
                build: (BuildContext context, double time) {
                  /// Disable when initiiazed
                  if (dur == time) {
                    controller.pause();
                  }
                  return CounterWidget(
                    time: time,
                  );
                },
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  print('Timer is done!');

                  /// Notify
                },
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
                    content: Text("Are You Sure To RESTART?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("Restart"),
                        onPressed: () async {
                          try {
                            Navigator.of(context).pop();
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
                double val = 2;
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    color: Colors.grey.shade200,
                    child: StatefulBuilder(
                      builder: (context, setState) => Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CupertinoSlider(
                            max: 10,
                            min: 1,
                            value: val,
                            divisions: 9,
                            onChanged: (double value) {
                              setState(() {
                                val = value.roundToDouble();
                              });
                            },
                          ),
                          Text("Val: $val"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
