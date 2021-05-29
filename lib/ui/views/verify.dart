import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:assistant/core/models/user.dart';
//import 'package:assistant/core/viewmodels/user_model.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:lambda/plugins/verify_input/verify_input.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/core/viewmodels/user_model.dart';

class VerifyPage extends StatefulWidget {
  final String verify;

  VerifyPage(this.verify);

  @override
  State<StatefulWidget> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final GlobalKey<FormState> _verifyFormKey = GlobalKey<FormState>();
  String code = '';
  NetworkUtil _netUtil = new NetworkUtil();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  doVerify(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    final state = Provider.of<UserModel>(context, listen: false);
    User user = state.getUser;

    ResponseModel response = await _netUtil.post('/api/mobile/verify',
        {"code": code, "user": user.id, "verify": widget.verify});

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context, listen: false);
      state.setUser(user);

      pr.update(message: response.msg, type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();
      if (widget.verify == 'register') {
        Navigator.pushNamed(context, '/register');
      } else {
        Navigator.pushNamed(context, '/reset');
      }
    } else {
      pr.update(message: response.msg, type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
    }
  }

  getVerifyKode(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    final state = Provider.of<UserModel>(context, listen: false);
    User user = state.getUser;

    ResponseModel response =
        await _netUtil.post('/api/mobile/resend-sms', {"user": user.id});

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context, listen: false);
      state.setUser(user);
      setState(() {
        code = '';
      });
      pr.update(message: response.msg, type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();
    } else {
      pr.update(message: response.msg, type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
//        onTap: () {
//          FocusScope.of(context).requestFocus(new FocusNode());
//        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/password.png',
                height: 130,
              ),
            ),
            Container(
              height: 200,
              padding: EdgeInsets.only(top: 30, left: 35, right: 35),
              child: Form(
                key: _verifyFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    VerifyInput(
                      length: 6,
                      itemSize: 40,
                      keyboardType: TextInputType.numberWithOptions(),
                      onCompleted: (val) {
                        setState(() {
                          code = val;
                        });
                      },
                      itemDecoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: .7, color: Colors.black54))),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 46,
                            margin: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                              color: Color(0xff0079FF),
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            child: FlatButton(
                              child: Container(
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Баталгаажуулах'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, .8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (this.code.length != 6) {
                                  Toast.show('Баталгаажуулах код буруу байна!',
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Color(0xffff4757),
                                      textColor: Color(0xccffffff));
                                } else {
                                  final form = this._verifyFormKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    this.doVerify(context);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20, left: 22, right: 22),
              child: Text(
                'Таны утасруу илгээсэн баталгаажуулах кодыг оруулна уу!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xff34495e)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 18, right: 20),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 8, right: 0, bottom: 15),
                      height: 18,
                      child: FlatButton(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'Баталгаажуулах код дахин авах бол энд дарна уу',
                                style: TextStyle(
                                    color: Color(0xff34495e),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          onPressed: () {
                            this.getVerifyKode(context);
                          }),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
