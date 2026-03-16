import 'package:cipherplant/components/theme.dart';
import 'package:cipherplant/pages/alt_home_page.dart';
import 'package:cipherplant/services/notifications_service.dart';
import 'package:flutter/material.dart';
// import 'package:cipherplant/pages/homePage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationsService.instance.init();
  final themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeNotifier),
        ChangeNotifierProvider.value(value: NotificationsService.instance),
        // Add more providers here as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: themeNotifier.lightTheme,
      darkTheme: themeNotifier.darkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
      home: AltHomePage(), // No need to pass realm anymore
    );
  }
}
