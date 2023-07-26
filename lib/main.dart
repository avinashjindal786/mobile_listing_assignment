import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile_listing_app/UI/home/home.dart';
import 'package:mobile_listing_app/utils/my_const/COLOR_CONST.dart';
import 'app/router.dart';
import 'core/repo/home_repository.dart';

const bool _intialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> loadNecessaryAssets() async {
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {},
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotification(_intialized, _firebaseMessaging);

  final fcmToken = await _firebaseMessaging.getToken();
  print('The token is $fcmToken');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadNecessaryAssets();
  runApp(MyApp());
}

void pushNotification(bool value, FirebaseMessaging firebaseMessaging) async {
  if (!value) {
    // For iOS request permission first.
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await _showNotification(1234, message.notification!.title, message.notification!.body, json.encode(message.data));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['navigation'] == "navigation") {
        Navigator.pushNamed(navigatorKey.currentState!.context, AppRouter.HOME);
      }
    });

    value = true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> _showNotification(
  int notificationId,
  String? notificationTitle,
  String? notificationContent,
  String payload, {
  String channelId = '1234',
  String channelTitle = 'Android Channel',
  String channelDescription = 'Default Android Channel for notifications',
  Priority notificationPriority = Priority.high,
  Importance notificationImportance = Importance.max,
}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelTitle,
    channelDescription: channelDescription,
    playSound: false,
    importance: notificationImportance,
    priority: notificationPriority,
  );
  var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(presentSound: false);
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    notificationId,
    notificationTitle,
    notificationContent,
    platformChannelSpecifics,
    payload: payload,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: COLOR_CONST.DEFAULT,
        // accentColor: COLOR_CONST.DEFAULT,
        hoverColor: COLOR_CONST.GREEN,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: HomeScreen(),
    );
  }
}
