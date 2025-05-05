
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:study_app/main.dart';
 Future<void> handleBackgroundMessage(RemoteMessage message) async {
     print('title : ${message.notification?.title}');
     print('body : ${message.notification?.body}');
      print('data : ${message.data}');
  }
class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  void handleMessage(RemoteMessage? message) {
    if(message == null) return;
    navigatorKey.currentState?.pushNamed('/auth', arguments: message.data);
  }
  Future initPushNotifications() async{
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
        FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
        FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  }
  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log('FCM Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }
}
