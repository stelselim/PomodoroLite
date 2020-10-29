import 'package:flutter/material.dart';
import 'package:pomodorolite/provider/appstate.dart';
import 'package:provider/provider.dart';

class RoundBar extends StatelessWidget {
  const RoundBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, _) {
      String title =
          state.pomodoroSettings.isWorkTime ? "Work Time" : "Break Time";

      List<Widget> completedRounds = List.generate(
        state.currentRound,
        (index) => Icon(Icons.check_box, color: Colors.blue.shade700),
      );

      List<Widget> rounds = List.generate(
        state.pomodoroSettings.rounds - state.currentRound,
        (index) => Icon(
          Icons.check_box_outline_blank,
        ),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Row(
            children: completedRounds + rounds,
          )
        ],
      );
    });
  }
}
