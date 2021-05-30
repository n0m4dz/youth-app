import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/views/verify.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import 'package:lambda/plugins/verify_input/verify_input.dart';
import '../../core/models/user.dart';

class RegisterByPhonePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterByPhonePage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool loading = false;
  String phone = '';
  NetworkUtil _netUtil = new NetworkUtil();

  @override
  void initState() {
    super.initState();
  }

  doRegister(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    ResponseModel response = await _netUtil.post('/api/mobile/register', {
      "phone": phone,
    });

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context, listen: false);
      state.setUser(user);

      pr.update(message: 'Амжилттай бүртгэгдлээ', type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();

      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => VerifyPage('register')));
      Navigator.pushNamed(context, '/verify');
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
      backgroundColor: Color(0xffFfffff),
      body: Stack(
        children: <Widget>[
          Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/register.png',
                    height: 150,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 50, left: 35, right: 35, bottom: 30),
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        VerifyInput(
                          length: 8,
                          itemSize: 35,
                          keyboardType: TextInputType.numberWithOptions(),
                          onCompleted: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
                          itemDecoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: .7,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        Container(
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
                                      'Илгээх'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, .8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              final form = this._registerFormKey.currentState;
                              if (form.validate()) {
                                form.save();
                                this.doRegister(context);
                              }
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
              height: 46,
              child: FlatButton(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      //Icons.ios_arrow_back,
                      FontAwesomeIcons.arrowLeft,
                      color: Color(0xff0079FF),
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Буцах',
                      style: TextStyle(
                        color: Color(0xff0079FF),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
