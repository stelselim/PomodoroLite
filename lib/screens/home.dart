import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodorolite/notifications/notifications_config.dart';
import 'package:pomodorolite/screens/pomodoro.dart';
import 'package:pomodorolite/utils/pomodoroPreferences.dart';

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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  /// Body Widgets
  List<Widget> bodyWidgets = [
    Pomodoro(),
    Center(
      child: Text(
        "Work In Progress!",
        textScaleFactor: 2,
      ),
    ),
  ];

  getNotificationPermissions() async {
    final bool result = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getLocalSettings(context),
        builder: (context, snapshot) {
          /// Try Once
          getNotificationPermissions();

          if (snapshot.data == null) {
            return CupertinoActivityIndicator();
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Problem!"),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey,
            appBar: CupertinoNavigationBar(
              middle: Text(
                "Pomodoro Lite",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.cyan.shade600,
                ),
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
        });
  }
}
