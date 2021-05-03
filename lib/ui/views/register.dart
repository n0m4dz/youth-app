import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/utils/helper.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/styles/_colors.dart' as prefix0;
import 'package:youth/ui/views/verify.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:lambda/plugins/progress_dialog/progress_dialog.dart';
import '../../core/models/user.dart';
import 'package:show_more_text_popup/show_more_text_popup.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String phone = '';
  String password = '';
  NetworkUtil _netUtil = new NetworkUtil();
  bool terms = false;
  GlobalKey key = new GlobalKey();

  List _aimagList = [];
  List _sumList = [];

  List<DropdownMenuItem<String>> _dropDownMenuItemsAimag;
  List<DropdownMenuItem<String>> _dropDownMenuItemsSum;
  var  _currentAimag;
  var  _currentSum;

  Future getAimagList() async {
    var url  = baseUrl + '/mobile/api/getAimags';
    var response = await _netUtil.get(url);
    var parsed = response.data['data'] as List<dynamic>;
    for (var item in parsed) {
      _aimagList.add(item);
    }
    _dropDownMenuItemsAimag = getDropDownMenuAimag();
    // _currentAimag = _dropDownMenuItemsAimag[0].value;
    setState(() {});
  }

  Future getSumList(aimagID) async {
    var url  = baseUrl + '/mobile/api/getSoums/' + aimagID;
    var response = await _netUtil.get(url);
    var parsed = response.data['data'] as List<dynamic>;
    _sumList = [];
    for (var item in parsed) {
      _sumList.add(item);
    }
    _dropDownMenuItemsSum = getDropDownMenuSum();
    _currentSum = _dropDownMenuItemsSum[0].value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAimagList();
    getSumList(22);
  }

  doRegister(BuildContext context) async {
    ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);

    FocusScope.of(context).requestFocus(new FocusNode());
    await Future.delayed(Duration(milliseconds: 300));

    pr.setMessage('Түр хүлээнэ үү...');
    pr.show();

    ResponseModel response = await _netUtil.post('/mobile/register', {
      "OrgOrHuman": "human",
      "email": email,
      "phone": phone,
      "password": password,
      "passwdCheck": password,
      "province": _currentAimag,
      "soum": _currentSum,
      "checked": false
    });

    if (response.status) {
      User user = new User.fromJson(response.data);
      final state = Provider.of<UserModel>(context);
      state.setUser(user);

      pr.update(message: 'Амжилттай бүртгэгдлээ', type: 'success');
      await new Future.delayed(const Duration(seconds: 1));
      pr.hide();

      await checkPermission(user.id);
      // Navigator.push(context,
      //     CupertinoPageRoute(builder: (context) => VerifyPage('register')));
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      pr.update(message: response.msg, type: 'error');
      await new Future.delayed(const Duration(milliseconds: 1500));
      pr.hide();
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuAimag() {
    List<DropdownMenuItem<String>> items = new List();
    _aimagList.forEach((city) {
        items.add(new DropdownMenuItem(
            value: city["id"].toString(),
            child: Row(
              children: [
                Icon(Icons.circle, size: 10, color: secondaryColor.withOpacity(0.6),),
                SizedBox(width: 10),
                Text(
                  city["ner"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
            // child: new Text(city["ner"])
        )
      );
    });

    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuSum() {
    print('getDropDownMenuSum');
    List<DropdownMenuItem<String>> items = new List();
    _sumList.forEach((city) {
      items.add(new DropdownMenuItem(
        value: city["id"].toString(),
        child: Row(
          children: [
            Icon(Icons.circle, size: 10, color: secondaryColor.withOpacity(0.6),),
            SizedBox(width: 10),
            Text(
              city["ner"],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
        // child: new Text(city["ner"])
      )
      );
    });

    return items;
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
                                initialValue: email,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Имэйл хаяг',
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
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(width: 1, color: Colors.lightGreen))
                                ),
                                style: TextStyle(color: Colors.white),
                                onSaved: (val) => email = val,
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
                                      new BorderRadius.circular(50.0)),
                              child: TextFormField(
                                initialValue: phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Утасны дугаар',
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.phone,
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onSaved: (val) => phone = val,
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
                                      new BorderRadius.circular(50.0)),
                              child: TextFormField(
                                initialValue: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Нууц үг',
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.lock,
                                      color: Color.fromRGBO(147, 157, 186, .78),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onSaved: (val) => password = val,
                              ),
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: secondaryLighten.withAlpha(16),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      color: secondaryLighten.withAlpha(90), style: BorderStyle.solid, width: 1.4),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.location_history_rounded,
                                            color:  Color.fromRGBO(147, 157, 186, .78),
                                            size: 20.09,
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                              'Аймаг сонгох',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(147, 157, 186, .78),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        ],
                                      ),
                                      value: _currentAimag,
                                      items: _dropDownMenuItemsAimag,
                                      onChanged: changedDropDownItemAimag,
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.lightBlue),
                                      dropdownColor: Colors.blue.withOpacity(0.9),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: secondaryLighten.withAlpha(16),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      color: secondaryLighten.withAlpha(90), style: BorderStyle.solid, width: 1.4),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.location_history_rounded,
                                            color:  Color.fromRGBO(147, 157, 186, .78),
                                            size: 20.09,
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                              'Сум сонгох',
                                              style: TextStyle(
                                                  color: Color.fromRGBO(147, 157, 186, .78),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400
                                              )
                                          ),
                                        ],
                                      ),
                                      value: _currentSum,
                                      items: _dropDownMenuItemsSum,
                                      onChanged: changedDropDownItemSum,
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.lightBlue),
                                      dropdownColor: Colors.blue.withOpacity(0.9),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 20,),
                                InkWell(
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      new Text(
                                        "Үйлчилгээний нөхцөл зөвшөөрөх",
                                        key: key,
                                        style: TextStyle(color: Colors.white,fontSize: 15, decoration: TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showMoreText('widget.text');
                                  },
                                ),
                                Theme(
                                  child: Checkbox(
                                    value: terms,
                                    onChanged: (bool value) {
                                      setState(() {
                                        terms = value;
                                      });
                                    },
                                  ),
                                  data: ThemeData(
                                    primarySwatch: Colors.blue,
                                    unselectedWidgetColor: secondaryColor, // Your color
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
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
                                      'Бүртгүүлэх'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: terms ? secondaryColor : Colors.black45,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if(terms){
                                    final form = this._registerFormKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      this.doRegister(context);
                                    }
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

  void changedDropDownItemAimag(String selectedAimag) {
    print('changed aimag');
    getSumList(selectedAimag);
    setState(() {
      _currentAimag = selectedAimag;
    });
  }

  void changedDropDownItemSum(String selectedSum) {
    setState(() {
      _currentSum = selectedSum;
    });
  }

  void showMoreText(String text) {
    ShowMoreTextPopup popup = ShowMoreTextPopup(context,
        text: text,
        textStyle: TextStyle(color: Colors.black),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(4.0),
        borderRadius: BorderRadius.circular(10.0));

    /// show the popup for specific widget
    popup.show(
      widgetKey: key,
    );
  }

}
