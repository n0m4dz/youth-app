import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:youth/core/utils/helper.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:lambda/modules/agent/agent_state.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:lambda/modules/agent/social_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences prefs;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  AgentUtil agentUtil = new AgentUtil();
  SocialAuth social = locator<SocialAuth>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) => initAuth());
  }

  fbLogin(BuildContext context) async {
//    bool isAuth = await social.fbLogin();
//    if (isAuth) {
//      prefs = await SharedPreferences.getInstance();
//      final userState = Provider.of<UserModel>(context);
//      String userData = prefs.getString('user');
//      User user = new User.fromJson(jsonDecode(userData));
//      userState.setUser(user);
//      await checkPermission(user.id);
//      Navigator.pushReplacementNamed(context, '/main');
//    }
  }

  initAuth() async {
    await agentUtil.init(context);
    await agentUtil.loadAgentData();

    final agentState = Provider.of<AgentState>(context);
    setState(() {
      email.text = agentState.login;
    });
  }

  bioLogin() async {
    final agentState = Provider.of<AgentState>(context);
    await agentUtil.bioLogin(context);
    setState(() {
      password.text = agentState.password;
    });
    this.doLogin();
  }

  doLogin() async {
    bool isAuth = await agentUtil.login(
        context, '/mobile/login', email.text, password.text);

    if (isAuth) {
      prefs = await SharedPreferences.getInstance();
      final userState = Provider.of<UserModel>(context);
      String userData = prefs.getString('user');
      User user = new User.fromJson(jsonDecode(userData));
      userState.setUser(user);
      await checkPermission(user.id);
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _agent = Provider.of<AgentState>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(
                        "assets/images/login-bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.1, .9],
                    colors: [
                      Color.fromRGBO(20, 27, 49, .98),
                      Color.fromRGBO(39, 60, 117, .75)
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/logo.png',
                              height: 125,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 320,
                          padding:
                              EdgeInsets.only(top: 30, left: 36, right: 36),
                          child: Form(
                            key: _loginFormKey,
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
                                    controller: email,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              147, 157, 186, .78),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Color.fromRGBO(
                                              147, 157, 186, .78),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                    onSaved: (val) => email.text = val,
                                  ),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
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
                                        new BorderRadius.circular(50.0),
                                  ),
                                  child: TextFormField(
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                147, 157, 186, .78),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Color.fromRGBO(
                                              147, 157, 186, .78),
                                          size: 22,
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      onSaved: (val) => password.text = val),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 28,
                                  child: Row(
                                    children: <Widget>[
                                      Switch(
                                        value: _agent.is_remember,
                                        onChanged: (value) {
                                          agentUtil.handleRemember(value);
                                        },
                                        activeTrackColor: secondaryLighten,
                                        activeColor: secondaryDarken,
                                      ),
                                      Text(
                                        'Remember me',
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                _agent.is_bio == true
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 28,
                                        child: Row(
                                          children: <Widget>[
                                            Switch(
                                              value: _agent.is_bio_remember,
                                              onChanged: (value) {
                                                agentUtil
                                                    .handleBioRemember(value);
                                              },
                                              activeTrackColor:
                                                  secondaryLighten,
                                              activeColor: secondaryDarken,
                                            ),
                                            Text(
                                              _agent.bio_txt == 'face'
                                                  ? 'Next time login with Face ID'
                                                  : 'Login with finger print',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            )
                                          ],
                                        ),
                                      )
                                    : SizedBox(height: 0),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 42,
                                        margin: EdgeInsets.only(top: 25),
                                        decoration: BoxDecoration(
                                          gradient: mainGradient,
                                          borderRadius:
                                              new BorderRadius.circular(50.0),
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
                                                'Login'.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            this
                                                ._loginFormKey
                                                .currentState
                                                .save();
                                            this.doLogin();
                                          },
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 44,
                                    //   margin: EdgeInsets.only(top: 28),
                                    //   decoration: BoxDecoration(
                                    //     gradient: mainGradient,
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: Color(0x36222222),
                                    //         blurRadius: 15.0,
                                    //         spreadRadius: .7,
                                    //         offset: Offset(3.0, 3.0),
                                    //       )
                                    //     ],
                                    //     borderRadius:
                                    //         new BorderRadius.circular(50.0),
                                    //   ),
                                    //   child: IconButton(
                                    //       icon: Icon(
                                    //         Icons.fingerprint,
                                    //         color: Colors.black87,
                                    //         size: 26,
                                    //       ),
                                    //       onPressed: () => bioLogin()),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 45, right: 0),
                                height: 22,
                                child: FlatButton(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'Forgot password ?',
                                        style: TextStyle(
                                            color: secondaryColor,
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/recovery');
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 23, right: 0, top: 10, bottom: 25),
                                height: 18,
                                child: FlatButton(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Wrap(
                                      children: <Widget>[
                                        Text(
                                          'Register',
                                          style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // Container(
                          //   margin: EdgeInsets.only(bottom: 15),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Expanded(
                          //         flex: 1,
                          //         child: Container(
                          //           margin:
                          //               EdgeInsets.only(left: 36, right: 36),
                          //           height: 42,
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //                   new BorderRadius.circular(50.0),
                          //               border: Border.all(
                          //                   color: Colors.white70, width: 2)),
                          //           child: FlatButton(
                          //               child: Wrap(
                          //                 children: <Widget>[
                          //                   Icon(Zocial.getIconData('facebook'),
                          //                       size: 16,
                          //                       color: Colors.white70),
                          //                   SizedBox(
                          //                     width: 5,
                          //                   ),
                          //                   Text(
                          //                     'Facebook',
                          //                     style: TextStyle(
                          //                         color: Colors.white70,
                          //                         fontSize: 16,
                          //                         fontWeight: FontWeight.w600),
                          //                   )
                          //                 ],
                          //               ),
                          //               onPressed: () => this.fbLogin(context)),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Text(
                            'Copyright © 2020 youth signal make',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                color: Color.fromRGBO(211, 216, 227, 0.9),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 40.0,
                  left: 20.0,
                  width: 40.0,
                  height: 40.0,
                  child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 33.0,
                          ))))
            ],
          ),
        ));
  }
}
