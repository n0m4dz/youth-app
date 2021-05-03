import 'package:flutter/material.dart';
import './ui/views/init.dart';
import './ui/views/login.dart';
import './ui/views/register.dart';
import './ui/views/recovery.dart';
import './ui/views/reset.dart';
import './ui/views/main.dart';

class Router {
  Router._();

  static final routes = <String, WidgetBuilder>{
    '/': (context) => InitScreen(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/recovery': (context) => RecoveryPage(),
    '/reset': (context) => ResetPage(),
    '/main': (context) => MainScreen(),
  };
}
