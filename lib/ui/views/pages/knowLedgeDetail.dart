import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/font_awesome.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KnowLedgeDetailPage extends StatefulWidget{

  final title;
  final thumb;
  final content;
  final type;
  final views;
  final created_at;

  const KnowLedgeDetailPage({Key key, this.title, this.thumb, this.created_at, this.content, this.type, this.views}) : super(key: key);

  @override
  KnowLedgeDetailPageState createState() => KnowLedgeDetailPageState();
}

class KnowLedgeDetailPageState extends State<KnowLedgeDetailPage>{

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: primaryColor.withOpacity(0.9),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.thumb == null ? baseUrl + "/assets/youth/images/noImage.jpg" :  baseUrl + widget.thumb.toString(),
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text(
                widget.title == null ? '' : widget.title,
                style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Html(
                    data: widget.content
                ),
              ),
              Container(
                height: 90,
                margin: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey,
                            width: 1
                        )
                    )
                ),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width - 25,
                        child: Row(
                          children: [
                            Icon(
                                Icons.access_time,
                                color: knowLedgeColor,
                                size: 14.0),
                            SizedBox(width: 5),
                            Text(
                              'Нэмсэн огноо: ',
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Text(
                              widget.created_at == null ? '' : DateFormat("y/MM/dd").format(DateTime.parse(widget.created_at)).toString(),
                              style: TextStyle(color: knowLedgeColor, fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color.fromRGBO(51, 142, 108, 0.9);
    var path = Path();
    path.lineTo(0, size.height - size.height / 12);
    // path.lineTo(size.width / 1.2, size.height);
    path.lineTo(size.width, size.height - size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}