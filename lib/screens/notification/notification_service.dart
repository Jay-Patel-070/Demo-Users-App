import 'dart:convert';
import 'package:demo_users_app/bottom_navigation_barr.dart';
import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/screens/notification/model/notification_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../main.dart';
import '../../utils/utils.dart';

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // Handle the background notification response here
//   print('notificationTapBackground: ${notificationResponse.payload}');
// }

String? _initialPayload;
String? get initialPayload => _initialPayload;

class NotificationService {
  // Singleton
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  /// Initialize notifications
  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    await _notifications.initialize(initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,

    );
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      _initialPayload = details!.notificationResponse?.payload;
    }
    // final details = await _notifications.getNotificationAppLaunchDetails();
    // if(details?.didNotificationLaunchApp ?? false){
    //   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => NotificationScreen(),));
    // }
    await reschedulePendingNotifications();
  }

  static _onNotificationTap(NotificationResponse response) {
    if(response.payload == "schedule notification"){
      Future.delayed(Duration(
        seconds: 2
      ),() {
        callNextScreenAndClearStack(navigatorKey.currentContext!, BottomNavigationBarr(isfromnotificationtap: true,));
      },);
    }
  }

  void handleInitialNavigation() {
    if (_initialPayload == "schedule notification") {
      Future.delayed(Duration(seconds: 2),() {
        callNextScreenAndClearStack(navigatorKey.currentContext!, BottomNavigationBarr(isfromnotificationtap: true,));
        },
      );
      // // Clear the payload after handling to prevent re-navigation
      // _initialPayload = null;
    }
  }

  /// Show an instant notification
  Future<void> showInstantNotification(NotificationModel model) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'direct_channel',
        'Direct Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _notifications.show(
      int.parse(model.id!),
      model.title,
      model.description,
      details,
      payload: "open-notification-screen",
    );
  }

  /// Schedule a notification
  Future<void> scheduleNotification(NotificationModel model) async {
    final scheduledTime = tz.TZDateTime.from(
      DateTime.parse(model.scheduledTime!),
      tz.local,
    );

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'scheduled_channel',
        'Scheduled Notifications',
        importance: Importance.max,
      ),
    );

    await _notifications.zonedSchedule(
      int.parse(model.id!),
      model.title,
      model.description,
      scheduledTime,
      details,
      payload: "schedule notification",
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Reschedule all pending scheduled notifications
  Future<void> reschedulePendingNotifications() async {
    final raw = sharedprefshelper.getData(LocalStorageKeys.notifications);

    if (raw == null) return;

    final decoded = jsonDecode(raw) as List;
    List<NotificationModel> list =
    decoded.map((e) => NotificationModel.fromJson(e)).toList();

    final now = DateTime.now();

    for (var n in list) {
      if (n.isScheduled == true) {
        final scheduledTime = DateTime.parse(n.scheduledTime!);
        if (scheduledTime.isAfter(now)) {
          await scheduleNotification(n);
        }
      }
    }
  }
}
