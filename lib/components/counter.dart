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
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade500,
        backgroundBlendMode: BlendMode.darken,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blueGrey.shade200,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: Text(
        "$minutes:$seconds",
        style: TextStyle(
          fontSize: 75,
          color: Colors.cyan.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BreakCounterWidget extends StatelessWidget {
  final double time;

  const BreakCounterWidget({
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
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade500,
        backgroundBlendMode: BlendMode.darken,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blueGrey.shade200,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: Text(
        "$minutes:$seconds",
        style: TextStyle(
          fontSize: 75,
          color: Colors.deepPurple.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CompletedCounterWidget extends StatelessWidget {
  final int rounds;

  const CompletedCounterWidget({
    Key key,
    @required this.rounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade500,
        backgroundBlendMode: BlendMode.darken,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blueGrey.shade100,
            Colors.grey.shade300,
          ],
        ),
      ),
      child: Text(
        "Completed!",
        style: TextStyle(
          fontSize: 45,
          color: Colors.green.shade600,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
