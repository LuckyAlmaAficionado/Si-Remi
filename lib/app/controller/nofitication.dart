import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  static FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  static Future initPerminssionHandler() async {
    await Permission.notification.isDenied.then((value) {
      if (value) Permission.notification.request();
    });
  }

  static Future initNofitication() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // init plugin
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flnp.initialize(initializationSettings);
  }

  // cencel all notification
  Future<void> cancelingAllnotification() async {
    await flnp.cancelAll();
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required TimeOfDay reminder,
    required int day,
    required int month,
    required int year,
  }) async {
    try {
      var now = tz.TZDateTime.now(tz.local);
      var scheduleDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        reminder.hour,
        reminder.minute,
      );

      if (scheduleDate.isBefore(now)) {
        scheduleDate = scheduleDate.add(const Duration(days: 1));
        print('masuk sini');
      }

      var androidPlatformChannelSpecifies =
          const AndroidNotificationDetails('reminder', 'reminder_medicine');

      var platformChannelSpecifies = NotificationDetails(
        android: androidPlatformChannelSpecifies,
      );

      await flnp.zonedSchedule(
        DateTime.now().microsecond,
        title,
        body,
        scheduleDate,
        platformChannelSpecifies,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );

      print('notificasi berhasil dibuat');
    } catch (e) {
      throw e;
    }
  }
}
