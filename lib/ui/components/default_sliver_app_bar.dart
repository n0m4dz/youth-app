import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/login.dart';
import 'package:youth/ui/views/notifications.dart';
import 'package:youth/ui/views/settings.dart';

import '../../size_config.dart';

class DefaultSliverAppBar extends StatelessWidget {
  const DefaultSliverAppBar({
    Key key,
    this.color,
    this.svgData,
    this.title,
    this.titleColor,
  }) : super(key: key);

  final String title;
  final Color color;
  final Color titleColor;
  final String svgData;

  @override
  Widget build(BuildContext context) {
    User user;
    SharedPreferences _prefs;
    return SliverAppBar(
      expandedHeight: getProportionateScreenHeight(200),
      floating: false,
      pinned: true,
      backgroundColor: color,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: titleColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        background: SvgPicture.asset(
          svgData,
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => NotificationsScreen(),
                ),
              );
            },
            child: Icon(
              Ionicons.getIconData('ios-notifications-outline'),
              size: 31,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              print('------user');
              print(user);

              if (user == null) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              } else {
                if (_prefs == null
                    ? false
                    : _prefs.getBool("is_auth") == false) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                }
              }
            },
            child: Icon(
              Ionicons.getIconData('ios-contact'),
              size: 31,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
