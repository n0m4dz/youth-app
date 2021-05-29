import 'dart:convert';

//import 'package:assistant/core/models/user.dart';
//import 'package:assistant/core/animations/FadeAnimation.dart';
//import 'package:assistant/core/viewmodels/user_model.dart';
import 'package:custom_fade_animation/custom_fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:assistant/ui/styles/_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lambda/modules/agent/agent_state.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youth/ui/styles/_colors.dart';

import '../../locator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  AgentUtil agentUtil = locator<AgentUtil>();
  AgentState agentState;

  SharedPreferences prefs;
  TextEditingController login = new TextEditingController();
  TextEditingController password = new TextEditingController();

  initAuth() async {
//    agentUtil.logout();
    var isAuth = await agentUtil.checkAuth() ?? false;
    if (isAuth) {
      prefs = await SharedPreferences.getInstance();
      String userData = prefs.getString('user');
      //final userState = Provider.of<UserModel>(context,listen:false);
      //User user = new User.fromJson(jsonDecode(userData));
      //userState.setUser(user);
      Navigator.of(context).pushReplacementNamed('/main');
    }

    await agentUtil.init(context);
    await agentUtil.loadAgentData();

    final agentState = Provider.of<AgentState>(context, listen: false);
    setState(() {
      login.text = agentState.login;
      password.text = agentState.password;
    });
  }

  bioLogin() async {
    agentState = Provider.of<AgentState>(context);
    await agentUtil.bioLogin(context);
    setState(() {
      password.text = agentState.password;
    });
    this.doLogin();
  }

  doLogin() async {
    //Navigator.pushReplacementNamed(context, '/main');

    bool isAuth = await agentUtil.login(
        context, '/api/mobile/login', login.text, password.text);
    if (isAuth) {
      var prefs = await SharedPreferences.getInstance();
      //final userState = Provider.of<UserModel>(context, listen: false);
      //String userData = prefs.getString('user');
      //User user = new User.fromJson(jsonDecode(userData));
      //userState.setUser(user);
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await initAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _agent = Provider.of<AgentState>(context);

    return Scaffold(
      //backgroundColor: Colors.grey[600],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(1.9, 1.0),
              colors: [
                const Color(0xff00337f),
                const Color(0xff00337f)
              ], // red to yellow
            ),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.8,
                child: Center(
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -40),
                child: FadeAnimation(
                    1,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 30.0, right: 30.0, bottom: 0.0, left: 30.0),
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Mend',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 28,
                          //       ),
                          //     ),
                          //     Text(
                          //       ' Assistant',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 28,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 2.0,
                          // ),
                          // Center(
                          //   child: Text(
                          //     'We care for your health',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w300,
                          //       fontSize: 14,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 40,
                          // ),

                          Container(
                            padding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 15, right: 15),
                            child: Form(
                              key: _loginFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 42,
                                    child: TextFormField(
                                      controller: login,
                                      style:
                                          new TextStyle(color: Colors.white70),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.black54,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        labelText: 'Утасны дугаар',
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                                color: Colors.white54)),
                                        hintStyle: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffffffff),
                                            )),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.red)),
                                        errorStyle: TextStyle(height: 0),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            //Feather.user,
                                            FontAwesomeIcons.user,
                                            color: Colors.white70,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      validator: (val) {
                                        return val.isEmpty ? '' : null;
                                      },
                                      onSaved: (val) => login.text = val,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.0,
                                  ),
                                  Container(
                                    height: 42,
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: true,
                                      style:
                                          new TextStyle(color: Colors.white70),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.white70,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: BorderSide(
                                              color: Colors.white70,
                                            )),
                                        labelText: 'Нууц үг',
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70),
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                147, 157, 186, .78),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.white70,
                                            )),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.red)),
                                        errorStyle: TextStyle(height: 0),
                                        prefixIcon: Icon(
                                          //Feather.lock,
                                          FontAwesomeIcons.lock,
                                          color: Colors.white70,
                                          size: 18,
                                        ),
                                      ),
                                      onSaved: (val) => password.text = val,
                                      validator: (val) {
                                        return val.isEmpty ? '' : null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 24,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Checkbox(
                                          value: _agent.is_remember,
                                          onChanged: (value) {
                                            //print('working ${value}');
                                            agentUtil.handleRemember(value);
                                          },
                                          activeColor: Colors.white,
                                        ),
                                        Text(
                                          'Сануулах',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 22,
                                            child: FlatButton(
                                                padding: EdgeInsets.only(
                                                    left: 0, right: 5),
                                                child: Wrap(
                                                  children: <Widget>[
                                                    Text(
                                                      'Нууц үгээ мартсан?',
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 14.5,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/recovery');
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          margin: EdgeInsets.only(top: 24),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                new BorderRadius.circular(50.0),
                                          ),
                                          child: FlatButton(
                                            child: Container(
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      'Нэвтрэх'.toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              .8),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              final form = this
                                                  ._loginFormKey
                                                  .currentState;
                                              if (form.validate()) {
                                                form.save();
                                                this.doLogin();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Row(
                                  //   crossAxisAlignment:
                                  //   CrossAxisAlignment.center,
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     Expanded(
                                  //       flex: 1,
                                  //       child: Container(
                                  //         height: 40,
                                  //         margin: EdgeInsets.only(top: 24),
                                  //         decoration: BoxDecoration(
                                  //           color: primaryColor,
                                  //           borderRadius:
                                  //           new BorderRadius.circular(50.0),
                                  //         ),
                                  //         child: FlatButton(
                                  //           child: Container(
                                  //             child: Stack(
                                  //               fit: StackFit.expand,
                                  //               children: <Widget>[
                                  //                 Center(
                                  //                   child: Text(
                                  //                     'Дан системээр нэвтрэх'.toUpperCase(),
                                  //                     textAlign:
                                  //                     TextAlign.center,
                                  //                     style: TextStyle(
                                  //                         color: Color.fromRGBO(
                                  //                             255,
                                  //                             255,
                                  //                             255,
                                  //                             .8),
                                  //                         fontSize: 16,
                                  //                         fontWeight:
                                  //                         FontWeight.w400),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           onPressed: () {
                                  //             final form = this
                                  //                 ._loginFormKey
                                  //                 .currentState;
                                  //             if (form.validate()) {
                                  //               form.save();
                                  //               this.doLogin();
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),

                          // Container(
                          //   margin: EdgeInsets.only(top: 30),
                          //   child: Text("Сошиал хаягаар нэвтрэх", style: TextStyle(color: Color(0xffababab)),),
                          // ),
                        ],
                      ),
                    )),
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
                            padding: EdgeInsets.only(left: 0, right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Та шинээр бүртгүүлэх бол ',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'энд дарна уу',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            onPressed: () {
                              // Navigator.pushNamed(
                              //     context, '/register_by_phone');
                              Navigator.pushNamed(context, '/register');
                            }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/images/logo.png');
    Image image = Image(image: assetImage);
    return Container(child: image);
  }
}
