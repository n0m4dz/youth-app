import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/font_awesome.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PodCastDetailPage extends StatefulWidget{

  final title;
  final img;
  final content;
  final guest;
  final embed;
  final link;
  final views;
  final created_at;

  const PodCastDetailPage({Key key, this.title, this.img, this.created_at, this.content, this.guest, this.views, this.link, this.embed}) : super(key: key);

  @override
  PodCastDetailPageState createState() => PodCastDetailPageState();
}

class PodCastDetailPageState extends State<PodCastDetailPage>{

  final _key = UniqueKey();
  bool _isLoadingPage = false;
  WebViewController webController;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

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
              backgroundColor: podCastColor.withOpacity(0.9),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.img == null ? baseUrl + "/assets/youth/images/noImage.jpg" :  baseUrl + widget.img.toString(),
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title == null ? '' : widget.title,
                style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  widget.content
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Html(
                  data: widget.embed,
                )
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:  Stack(
        children: <Widget>[
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: size.height * 0.3 + 20,
              bottom: 0,
              left: 0,
              child: Container(
                  height: size.height * 0.7,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  )
              )
          ),
          // Positioned(
          //   top: 0.0,
          //   left: 0.0,
          //   width: size.width,
          //   height: size.height * 0.35,
          //   child: CustomPaint(
          //     painter: CurvePainter(),
          //   ),
          // ),
          Positioned(
              top: 0,
              right: 0,
              width: size.width,
              height: size.height * 0.3,
              child: Container(
                height: size.height * 0.2,
                width: size.width,
                // color: Colors.greenAccent,
                child: Image.network(
                  widget.img == null ? baseUrl + "/assets/youth/images/noImage.jpg" :  baseUrl + widget.img.toString(),
                  height: MediaQuery.of(context).size.height,
                  width: size.width,
                  fit:BoxFit.fitWidth,
                ),
              )
          ),
          // Positioned(
          //     top: 47.0,
          //     right: 20,
          //     width: size.width,
          //     child: Align(
          //         alignment: Alignment.topRight,
          //         child: Text(
          //           'Сайн дурын ажил'.toUpperCase(),
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 20
          //           ),
          //         )
          //     )
          // ),
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