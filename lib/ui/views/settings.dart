import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/components/bottom_modal.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/profile.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/header.dart';
import 'privacy.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User user;
  AgentUtil agentUtil = new AgentUtil();
  bool isNetworkImage = true;
  SharedPreferences _prefs;
  String xp;

  Widget getAvatarThumb(String avatarPath) {
    if (avatarPath == null || avatarPath == '') {
      return CircleAvatar(
        radius: 44,
        backgroundImage: AssetImage('assets/images/avatar2.png'),
      );
    } else {
      var urlPattern =
          r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
      var match =
          new RegExp(urlPattern, caseSensitive: false).firstMatch(avatarPath);

      if (match == null) {
        return CircleAvatar(
          radius: 44,
          backgroundImage: NetworkImage(baseUrl + avatarPath),
        );
      }

      return CircleAvatar(
        radius: 44,
        backgroundImage: NetworkImage(avatarPath),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _prefs = await SharedPreferences.getInstance();
      setState(() {
        xp = _prefs.getString('xp');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserModel>(context);
    user = userState.getUser;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: secondaryColor,
          centerTitle: false,
          title: Text(
            'Миний булан'.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(
                color: primaryColor, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          leading: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              print('working back btn');
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(
                Ionicons.getIconData('ios-arrow-back'),
                color: primaryColor,
              ),
            ),
          ),
          elevation: 0,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
                padding: EdgeInsets.only(top: 50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 30, bottom: 0, right: 10, left: 10),
                      child: Column(
                        children: <Widget>[
                          user != null
                              ? CircleAvatar(
                                  radius: 44,
                                  //backgroundImage: user.image != null ? AssetImage(user.image) : AssetImage('assets/images/avatar2.png'),
                                )
                              : CircleAvatar(
                                  radius: 44,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar2.png'),
                                ),
                          SizedBox(
                            height: 11,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              user != null
                                  ? Text(
                                      user.email != null
                                          ? user.email
                                          : 'Хэрэглэгчийн и мэйл бүртгэлгүй байна',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xff7a7e8b),
                                      ),
                                    )
                                  : Text(
                                      'Хэрэглэгч нэвтрээгүй',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Color(0xff7a7e8b),
                                      ),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff7a7e8b),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(left: 40),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Feather.getIconData('edit-2'),
                              color: Color(0xff5c6d7e)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Хувийн мэдээлэл',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff5c6d7e),
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 48,
                  //   margin: EdgeInsets.only(left: 40),
                  //   child: FlatButton(
                  //     onPressed: () => _pointModalBottomSheet(context),
                  //     child: Row(
                  //       children: <Widget>[
                  //         Icon(Feather.getIconData('credit-card'),
                  //             color: Color(0xff5c6d7e)),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text('Дэлгэрэнгүй анкет',
                  //             style: TextStyle(
                  //                 fontSize: 18,
                  //                 color: Color(0xff5c6d7e),
                  //                 fontWeight: FontWeight.w500))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 48,
                    margin: EdgeInsets.only(
                        bottom: 20, left: 20, right: 20, top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Гарах'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Feather.getIconData('log-out'),
                              color: secondaryColor,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        await agentUtil.logout();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void _pointModalBottomSheet(context) {
    showBottomModal(
      context: context,
      builder: (builder) {},
    );
  }
}
