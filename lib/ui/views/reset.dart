import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/views/verify.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import '../../core/models/user.dart';

class ResetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool loading = false;
  String password = '';
  NetworkUtil _netUtil = new NetworkUtil();

  @override
  void initState() {
    super.initState();
  }

  doReset() async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);
    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 500));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    final state = Provider.of<UserModel>(context);
    User user = state.getUser;

    ResponseModel response = await _netUtil
        .post('/api/m/reset/password', {"password": password, 'user': user.id});

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context);
      state.setUser(user);

      pr.update(message: response.msg, type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();

      Navigator.pushReplacementNamed(context, '/login');
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
      body: Stack(
        children: <Widget>[
          Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'lib/apps/youth/assets/images/register.png',
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
                        TextFormField(
                          initialValue: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            labelText: 'Шинэ нууц үг',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(147, 157, 186, .78),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color.fromRGBO(147, 157, 186, .78),
                              size: 22,
                            ),
                          ),
                          onSaved: (val) => password = val,
                          validator: (val) {
                            return val.isEmpty ? 'Нууц үгээ оруулна уу!' : null;
                          },
                        ),
                        SizedBox(
                          height: 25.0,
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
                                      'Нууц үг солих'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, .8),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              final form = this._registerFormKey.currentState;
                              if (form.validate()) {
                                form.save();
                                this.doReset();
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
              height: 36,
              child: FlatButton(
                  padding: EdgeInsets.only(top: 15, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Ionicons.getIconData('ios-arrow-back'),
                        color: Color(0xff0079FF),
                        size: 22,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Буцах',
                        style: TextStyle(
                            color: Color(0xff0079FF),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context)),
            ),
          ),
        ],
      ),
    );
  }
}
