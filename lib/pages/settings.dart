// import 'package:cipherplant/pages/myPlants.dart';
// import 'package:cipherplant/pages/plantHealth.dart';

import 'package:cipherplant/components/textAnimations.dart';
import 'package:cipherplant/components/theme.dart';
import 'package:cipherplant/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isRestricted) {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        print("🔔 Notification permission granted");
      } else {
        print("❌ Notification permission denied");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.themeMode == ThemeMode.dark;
    final notificationNotifier = Provider.of<NotificationsService>(context);

    // final notificationNotifier =
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Notifications'),
                Switch(
                  // This bool value toggles the switch.
                  value: notificationNotifier.onNotification,
                  // activeColor: Colors.red,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    final notificationsService =
                        context.read<NotificationsService>();

                    setState(() {
                      notificationNotifier.onNotification = value;
                      if (notificationNotifier.onNotification == false) {
                        notificationsService.cancelAll();
                        SubtitleManager().show(context, [
                          "You've disabled the frequency.",
                          "But remember:",
                          "even in darkness, something always grows",
                        ]);
                      } else {
                        // notificationsService.scheduleReminder(
                        //     id: 69, title: 'hello there'); used for debugging
                        notificationsService.scheduleDailyReminder();

                        SubtitleManager().show(context, [
                          "Your purpose is clear. A single ping",
                          "A quiet revolution in chlorophyll",
                        ]);
                      }
                      print({
                        'notification flag',
                        notificationNotifier.onNotification
                      });
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Theme'),
                Switch(
                  // This bool value toggles the switch.
                  value: isDark,
                  // activeColor: Colors.red,
                  onChanged: (value) {
                    // This is called when the user toggles the switch.
                    if (value == true) {
                      SubtitleManager().show(context, [
                        "You've chosen the shadows.",
                        "Here, roots go deeper",
                        "and truth grows darker",
                      ]);
                    } else {
                      SubtitleManager().show(context, [
                        "Light reveals all.",
                        "Leaves stretch.",
                        "So does your responsibility.",
                      ]);
                    }
                    themeNotifier.toggleTheme(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
