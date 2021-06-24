import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/ui/styles/_colors.dart';
import '../components/loader.dart';
import 'package:youth/ui/views/base_view.dart';

class TermsScreen extends StatefulWidget {
  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  Map<String, dynamic> item;
  NetworkUtil _http = new NetworkUtil();
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future getItemList() async {
    var url = baseUrl + '/api/mobile/getOtherPage/4';
    var response = await _http.get(url);

    item = response.data['data'];

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          item == null ? '' : item['title'],
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
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
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Html(
              data: item == null ? '' : item['body'],
              style: {
                "h1": Style(color: textColor, fontSize: FontSize.larger),
                "p": Style(color: textColor),
                "li": Style(color: textColor, fontSize: FontSize.large),
              },
            ),
          ),
        ],
      ),
    );
  }
}
