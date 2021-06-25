import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/font_awesome.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ELearnDetailPage extends StatefulWidget {
  final title;
  final thumb;
  final description;
  final body;
  final teachername;
  final updated_at;
  final created_at;

  const ELearnDetailPage(
      {Key key,
      this.title,
      this.thumb,
      this.created_at,
      this.description,
      this.body,
      this.teachername,
      this.updated_at})
      : super(key: key);

  @override
  ELearnDetailPageState createState() => ELearnDetailPageState();
}

class ELearnDetailPageState extends State<ELearnDetailPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: eLearnColor,
        ),
        child: Column(
          children: [
            Container(
              height: widget.title.length > 70 ? 210 : 165,
              padding: EdgeInsets.only(top: 60, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.title == null ? '' : widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: bgColor,
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      child: Html(data: widget.body),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 30,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width - 25,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: eLearnColor,
                                  size: 14.0,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Шинэчилсэн огноо: ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.updated_at == null
                                      ? ''
                                      : DateFormat("y/MM/dd")
                                          .format(
                                              DateTime.parse(widget.updated_at))
                                          .toString(),
                                  style: TextStyle(
                                    color: eLearnColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0, bottom: 10),
                            width: MediaQuery.of(context).size.width - 25,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: eLearnColor,
                                  size: 14.0,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Нэмсэн огноо: ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.created_at == null
                                      ? ''
                                      : DateFormat("y/MM/dd")
                                          .format(
                                              DateTime.parse(widget.created_at))
                                          .toString(),
                                  style: TextStyle(
                                    color: eLearnColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0, bottom: 10),
                            width: MediaQuery.of(context).size.width - 25,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: eLearnColor,
                                  size: 14.0,
                                ),
                                SizedBox(width: 5),
                                widget.teachername.length > 25
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Бэлтгэсэн багш: ',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8,
                                            child: Text(
                                              widget.teachername == null
                                                  ? '__'
                                                  : widget.teachername
                                                      .toString(),
                                              style: TextStyle(
                                                color: eLearnColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            'Бэлтгэсэн багш: ',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            widget.teachername == null
                                                ? '__'
                                                : widget.teachername.toString(),
                                            style: TextStyle(
                                              color: eLearnColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
