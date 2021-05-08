import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../network_util.dart';

class Notify {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  NetworkUtil _netUtil = new NetworkUtil();
  SharedPreferences _prefs;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Dio dio = Dio();

  getPermission(String url, BuildContext context) {
    // initLocalNotification();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print('DATA IOS: ${data}');
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    // _fcm.subscribeToTopic('topic');
  }

  initLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_stat_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: null);
  }

//  getDeviceToken(String url) async {
//    String fcmToken = await _fcm.getToken();
//    print("TOKEN PUSH: ${fcmToken}");
//
//    if (fcmToken != null) {
//      await this.setToken(url, fcmToken);
//    }
//  }

  setToken(userId) async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('gcmToken') == null) {
      String fcmToken = await _fcm.getToken();
      if (fcmToken != null) {
        _prefs.setString("gcmToken", fcmToken);
        var resp = await _netUtil.get('/token/${userId}/${fcmToken}',
            base: "https://youth.bits.mn/api");
      }
    }
  }

  showToast(context, String type, String msg) {
    int bgColor = 0xcceb4d4b;

    if (type == "success") {
      bgColor = 0xcc2ecc71;
    }

    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Color(bgColor),
        textColor: Color(0xccffffff));
  }

  showNotification(String title, String msg) async {
    print("local notification showing --> $title");
    var rdm = new Random();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.bitsoft.animax', 'Animax', 'notification_channel',
        importance: Importance.max,
        priority: Priority.high,
        enableLights: true);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      rdm.nextInt(64),
      title,
      msg,
      platformChannelSpecifics,
      payload: "main",
    );
  }

  onClickNotification() {}

  Future<void> checkPermission() async {
    _prefs = await SharedPreferences.getInstance();
    String userId = _prefs.getString("userId");

    var response = await _netUtil.get('/check/notify/${userId}');

    _prefs.setBool("watch", response.data['watchAccess']);
    _prefs.setBool("hentai", response.data['hentaiAccess']);
    _prefs.setString("xp", response.data['xp'].toString());
    _prefs.setString("day", response.data['day'].toString());

    if (response.data['hasNotification'] == true) {
      _prefs.setBool("hasNotification", true);
    } else {
      _prefs.setBool("hasNotification", false);
    }
  }

  handleNotification(Map<String, dynamic> message, String type) async {
    if (message['data'] != null) {
      if (message['data']['type'] == 'payment' && Platform.isAndroid) {
        await checkPermission();
        showNotification(
            message['notification']['title'], message['notification']['body']);
      }

      if (message['data']['type'] == 'payment' && Platform.isIOS) {
        await checkPermission();
        showNotification(
            message['notification']['title'], message['notification']['body']);
      }

      if (message['data']['type'] == 'episode') {
        showNotification(
            message['notification']['title'], message['notification']['body']);
      }
    } else {
      showNotification(
          message['notification']['title'], message['notification']['body']);
    }
  }

  configFcm(ctx) {
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      handleNotification(message, "On message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("on launch");
      // handleNotification(message, "On launch");
    }, onResume: (Map<String, dynamic> message) async {
      print("on resumre");
      // handleNotification(message, "On resume");
    });
  }
}
