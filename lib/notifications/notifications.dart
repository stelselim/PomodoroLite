import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> workFinishedNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'PomodoroLite',
    'PomodoroLite Work Time',
    'Work Time Finished Notification',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    channelShowBadge: true,
    enableVibration: true,
    playSound: true,
  );
  const iOSPlatformChannelSpecifics = IOSNotificationDetails(
    badgeNumber: 0,
    presentAlert: true,
    presentSound: true,
    presentBadge: true,
    subtitle: "Work Time Finished",
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    'PomodoroLite',
    'Break Time!',
    platformChannelSpecifics,
  );
}

Future<void> breakFinishedNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'PomodoroLite',
    'PomodoroLite Break Time',
    'Break Time Finished Notification',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    channelShowBadge: true,
    enableVibration: true,
    playSound: true,
  );
  const iOSPlatformChannelSpecifics = IOSNotificationDetails(
    badgeNumber: 0,
    presentAlert: true,
    presentSound: true,
    presentBadge: true,
    subtitle: "Break Time Finished",
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    'PomodoroLite',
    'Break Time!',
    platformChannelSpecifics,
  );
}

/*
 * Not USED Below
 */

Future notificationSchedule() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  tz.initializeTimeZones();

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Scheduled',
    'scheduled body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
    const NotificationDetails(
        android: AndroidNotificationDetails('your channel id',
            'your channel name', 'your channel description')),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future periodicSchedule() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Show a notification every minute with the first appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
      'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics);
}

Future deleteNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // cancel the notification with id value of zero
  await flutterLocalNotificationsPlugin.cancel(0);
}

Future deleteAllNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // cancel the notification with id value of zero
  await flutterLocalNotificationsPlugin.cancelAll();
}
