import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:youth/ui/styles/_colors.dart';
import '../components/header.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NetworkUtil _netUtil = new NetworkUtil();
  bool loading = true;

  final List<String> notificationList = ['', '', ''];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        // appBar: AppBar(
        //   titleSpacing: 0,
        //   backgroundColor: primaryColor,
        //   centerTitle: false,
        //   title: Text(
        //     'Мэдэгдэл'.toUpperCase(),
        //     textAlign: TextAlign.start,
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w600,
        //         fontSize: 18
        //     ),
        //   ),
        //   leading: FlatButton(
        //     padding: EdgeInsets.all(0),
        //     onPressed: () {
        //       print('working back btn');
        //       Navigator.pop(context);
        //     },
        //     child: Container(
        //       height: 30,
        //       width: 30,
        //       child: Icon(
        //         Ionicons.getIconData('ios-arrow-back'),
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        //   elevation: 0,
        // ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: primaryColor),
          title: const Text(
            'Мэдэгдэл',
            style: TextStyle(color: primaryColor),
          ),
          backgroundColor: Color(0xfff2f3fa),
          elevation: 0,
        ),
        body: Container(
            child: Center(
          child: Text(
            'Мэдэгдэл ирээгүй байна.',
            style: TextStyle(color: primaryColor),
          ),
        )));

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Header(
              title: 'Мэдэгдэл',
              reversed: false,
            ),
            Expanded(
              flex: 1,
              child: loading
                  ? Text('')
                  : ListView(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      children: <Widget>[
                        //News list
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
//                            child: Column(
//                                children:
//                                notificationList.map().toList())
                        ),
                      ],
                    ),
            ),
          ],
        )
      ],
    ));
  }
}
