import 'dart:async';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network_util.dart';

class Notify {
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  NetworkUtil _netUtil = new NetworkUtil();
  SharedPreferences _prefs;

  // getPermission(String url, BuildContext context) {
  //   if (Platform.isIOS) {
  //     iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
  //       print('DATA IOS: ${data}');
  //     });
  //     _fcm.requestNotificationPermissions(IosNotificationSettings());
  //   }
  //   _fcm.subscribeToTopic('topic');
  // }

  setToken(String url, int userId) async {
//     print("setting token");
//     _prefs = await SharedPreferences.getInstance();
// //    if (_prefs.getString('fcmToken') == null) {
//     String fcmToken = await _fcm.getToken();
//     print("TOKEN: ${fcmToken}");
//
//     if (fcmToken != null) {
//       await _netUtil.get('${url}?token=${fcmToken}&user=${userId.toString()}');
//     }
//    }
  }

  configFcm() {
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
  }
}
