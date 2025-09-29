import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lunari/core/services/log_service.dart';
import 'package:timezone/timezone.dart' as tz;
import "package:timezone/data/latest.dart" as tz;
import 'package:flutter_timezone/flutter_timezone.dart';


class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => isInitialized;

  //! Initialize:
  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Init timezone handling:
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Prepare android init settings:
    const initSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");

    // Prepare ios init settings:
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // init settings:
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    // finally, initialize the plugin:
    await notificationsPlugin.initialize(initSettings);

    _isInitialized = true;


  }

  //! Notifications detail setUP:
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_channel_id",
        "Daily Notifications",
        channelDescription: "Daily Notification Channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  //! Show Notification:
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async{
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),

    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    // get the current date:
    final now = tz.TZDateTime.now(tz.local);

    // create a date time  for today at the specified hour/min:
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Schedule Notification:
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,

      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      // make notifications repeat daily at the same time:
      matchDateTimeComponents: DateTimeComponents.time,
    );
    LogService.w("Notification Scheduled!");
  }

  // cancel all notifications:
  Future<void> cancelAllNotifications() async{
    await notificationsPlugin.cancelAll();
  }


}