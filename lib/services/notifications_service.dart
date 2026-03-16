// import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class NotificationsService extends ChangeNotifier {
  // static final NotificationsService instance = NotificationsService();
  static final NotificationsService instance = NotificationsService._internal();

  NotificationsService._internal();
  bool onNotification = true;

  final FlutterLocalNotificationsPlugin notification_plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    onNotification = prefs.getBool('OnNotification') ?? true;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      windows: const WindowsInitializationSettings(
        appName: 'CipherPlant',
        appUserModelId: 'com.cipherplant.app',
        guid: 'f1cf8e8b-dcbc-4d0e-8957-8793abf5156f',

        // defaultActionName: 'Open CipherPlant',
      ),
    );

    await notification_plugin.initialize(initSettings);
  }

  Future<void> toggleNotifications(bool value) async {
    onNotification = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('OnNotification', value);
    notifyListeners();
  }

  // Future<void> scheduleReminder({
  //   required int id,
  //   required String title,
  //   String? body,
  // }) async {
  //   TZDateTime now = TZDateTime.now(tz.local);
  //   TZDateTime scheduledDate = now.add(
  //     Duration(seconds: 5),
  //   );
  //   await notification_plugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     scheduledDate,
  //     const NotificationDetails(
  //       // `PAUSED here
  //       android: AndroidNotificationDetails(
  //         'plant_watering_reminder_channel',
  //         'Plant Watering Reminders',
  //         channelDescription: 'Reminder to complete daily habits',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //       iOS: DarwinNotificationDetails(),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //   );
  // }

  Future<void> scheduleDailyReminder() async {
    List<String> statements = [
      "Your plants just texted… they're thirsty! 💦",
      "Time to hydrate your leafy buddies 🌱",
      "Water day = happy plants = happy you 🌼",
      "Give your plants the drink they deserve 🍹",
      "A little water now, a lot of green later 🌳",
      "Don't leaf your plants hanging! 🌿",
      "They can't pour themselves a drink… yet 😏",
      "Sip, sip, hooray! It's watering time 🪴",
      "Roots are calling for a refill 📞💧",
      "Your plant army awaits their rations 🌾",
    ];

    final random = Random();
    String notification_statement =
        statements[random.nextInt(statements.length)];
    final now = TZDateTime.now(tz.local);
    var scheduledDate = TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      7,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(Duration(days: 1));
    }

    await notification_plugin.zonedSchedule(
      0,
      'Water your plants 🌿',
      notification_statement,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'plant_watering_reminder_channel',
          'Plant Watering Reminders',
          channelDescription: 'Reminder to complete daily habits',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancel(int id) async => await notification_plugin.cancel(id);

  Future<void> cancelAll() async => await notification_plugin.cancelAll();
}
