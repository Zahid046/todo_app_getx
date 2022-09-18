import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_getx/main.dart';

class HomeController extends GetxController {
  final Battery battery = Battery();
  final RxInt batteryLevel = RxInt(0);
  final TextEditingController maxLevelController = TextEditingController();
  final TextEditingController minLevelController = TextEditingController();

  BatteryState? batteryState;
  StreamSubscription<BatteryState>? batteryStateSubscription;

  final RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    // battery related
    isLoading.value = true;
    battery.batteryState.then(_updateBatteryState);
    batteryStateSubscription = battery.onBatteryStateChanged.listen(_updateBatteryState);
    _storeBatteryPercentage();

    super.onInit();
  }

  @override
  void onClose() {
    if (batteryStateSubscription != null) {
      batteryStateSubscription!.cancel();
    }
    super.onClose();
  }

  Future<void> _updateBatteryState(BatteryState state) async {
    debugPrint(state.toString());

    int level = await battery.batteryLevel;
    debugPrint('_updateBatteryState: $level');

    if (level == batteryLevel.value) {
      return;
    }

    var box = await Hive.openBox('myBox');
    int? sMax = box.get('max');
    int? sMin = box.get('min');
    if (sMax == null || sMin == null) {
      minLevelController.text = '20';
      maxLevelController.text = '80';
    } else {
      minLevelController.text = sMin.toString();
      maxLevelController.text = sMax.toString();
    }

    batteryLevel.value = level;

    bool? isMaxNotified = box.get('is_max_notified');
    bool? isMinNotified = box.get('is_min_notified');



    if (level >= int.parse(maxLevelController.text) && (isMaxNotified == null || !isMaxNotified)) {
      await _showNotificationWithNoTitle(
        level: level,
        max: int.parse(maxLevelController.text),
        min: int.parse(minLevelController.text),
      );
      await box.put('is_max_notified', true);
    } else if (level <= int.parse(minLevelController.text) && (isMinNotified == null || !isMinNotified)) {
      await _showNotificationWithNoTitle(
        level: level,
        max: int.parse(maxLevelController.text),
        min: int.parse(minLevelController.text),
      );
      await box.put('is_min_notified', true);
    }

    if (batteryState == state) {
      return;
    }

    batteryState = state;
  }

  Future<void> _showNotificationWithNoTitle({required int level, int max = 99, min = 30}) async {
    await flutterLocalNotificationsPlugin.cancel(0);

    IOSNotificationDetails iosPlatformChannelSpecifics = IOSNotificationDetails(
      subtitle: 'Current Battery Level: $level%',
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      styleInformation: DefaultStyleInformation(true, true),
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosPlatformChannelSpecifics,
      android: androidNotificationDetails,
    );

    var message = 'Battery Level: $level%';

    if (level >= max) {
      message = 'Battery Level: $level% - Please unplug the charger';

      await flutterLocalNotificationsPlugin.show(
        0,
        'Warning',
        message,
        platformChannelSpecifics,
      );
    } else if (level <= min) {
      message = 'Battery Level: $level% - Please plug the charger';

      await flutterLocalNotificationsPlugin.show(
        0,
        'Warning',
        message,
        platformChannelSpecifics,
      );
    }
  }

  Future<void> _storeBatteryPercentage() async {
    var box = await Hive.openBox('myBox');
    int? sMax = box.get('max');
    if (sMax != null) {
      debugPrint('have');
      maxLevelController.text = sMax.toString();
      minLevelController.text = box.get('min').toString();
    } else {
      minLevelController.text = '20';
      maxLevelController.text = '80';
      await box.put('max', int.parse(maxLevelController.text));
      await box.put('min', int.parse(minLevelController.text));
      debugPrint('do not have');
    }
    isLoading.value = false;
  }
}
