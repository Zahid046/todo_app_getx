import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_getx/constants/routes.dart';
import 'package:todo_app_getx/controllers/binder_controller.dart';
import 'package:todo_app_getx/helper/utility.dart';
import 'package:todo_app_getx/models/environment.dart';
import 'package:todo_app_getx/themes/theme_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.max,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
  requestSoundPermission: true,
  requestBadgePermission: true,
  requestAlertPermission: true,
);

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* info:: hive initialization
  await Hive.close();
  await dotenv.load(fileName: Environment.fileName);
  ll(Environment.fileName.toString());
  var directory = await path_provider.getApplicationDocumentsDirectory();
  log('path:${directory.path}');
  Hive.init(directory.path);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  //* status bar theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeft,
        theme: themeData,
        initialRoute: krTask,
        getPages: routes,
        initialBinding: BinderController(),
      ),
    );
  }
}
