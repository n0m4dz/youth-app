import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/styles/_colors.dart' as prefix0;
import 'package:youth/ui/views/verify.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import '../../core/models/user.dart';

class RecoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  NetworkUtil _netUtil = new NetworkUtil();

  @override
  void initState() {
    super.initState();
  }

  doRecovery(context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    ResponseModel response = await _netUtil.post('/api/m/recovery', {
      "email": email,
    });

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context);
      state.setUser(user);

      pr.update(message: 'Нууц үг сэргээх код илгээгдлээ', type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();

      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => VerifyPage('recover')));
    } else {
      pr.update(message: response.msg, type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff141B31),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/lock.png',
                        height: 150,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 50, left: 35, right: 35, bottom: 30),
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: secondaryLighten.withAlpha(16),
                                  border: Border.all(
                                      color: secondaryLighten.withAlpha(90),
                                      width: 1.4),
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your email address',
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.account_circle,
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 42,
                              margin: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                gradient: mainGradient,
                                borderRadius: new BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x36222222),
                                    blurRadius: 15.0,
                                    spreadRadius: .7,
                                    offset: Offset(3.0, 3.0),
                                  )
                                ],
                              ),
                              child: FlatButton(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      'Send reset code'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              SafeArea(
                child: Container(
                  height: 40,
                  child: FlatButton(
                      padding: EdgeInsets.only(top: 15, left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Ionicons.getIconData('ios-arrow-back'),
                            color: secondaryColor,
                            size: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              'Буцах',
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => Navigator.pop(context)),
                ),
              ),
            ],
          ),
        ));
  }
}
