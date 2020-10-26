import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final double time;

  const CounterWidget({
    Key key,
    @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dr = Duration(seconds: time.toInt());
    final String minutes = (dr.inSeconds ~/ 60) > 9.9
        ? (dr.inSeconds ~/ 60).toString()
        : ("0" + (dr.inSeconds ~/ 60).toString());
    final String seconds = (dr.inSeconds.remainder(60) > 9.9
        ? dr.inSeconds.remainder(60).toString()
        : ("0" + dr.inSeconds.remainder(60).toString()));

    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade100,
      child: Text(
        "$minutes:$seconds",
        style: TextStyle(
          fontSize: 75,
          color: Colors.deepPurple.shade600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
