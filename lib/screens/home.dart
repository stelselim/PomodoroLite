import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodorolite/screens/pomodoro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  /// setCurrent Body
  void onTapBottomTapItem(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  /// Body Widgets
  List<Widget> bodyWidgets = [
    Pomodoro(),
    Center(
      child: Text("Counter"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: CupertinoNavigationBar(
        middle: Text(
          "Pomodoro Lite",
          style: TextStyle(),
        ),
      ),
      body: CupertinoPageScaffold(
        child: IndexedStack(
          index: currentIndex,
          children: bodyWidgets,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: currentIndex,
        border: Border(top: BorderSide(width: 0.15)),
        onTap: (index) => onTapBottomTapItem(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_toggle_off),
          ),
        ],
      ),
    );
  }
}
