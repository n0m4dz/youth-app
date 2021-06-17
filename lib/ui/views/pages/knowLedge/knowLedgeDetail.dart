import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/knowledge.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class KnowLedgeDetailPage extends StatefulWidget {
  final KnowLedge item;

  const KnowLedgeDetailPage({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  KnowLedgeDetailPageState createState() => KnowLedgeDetailPageState();
}

class KnowLedgeDetailPageState extends State<KnowLedgeDetailPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: knowLedgeColor,
        title: Text(
          'Мэдлэг мэдээлэл'.toUpperCase(),
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Text(
                  widget.item.title == null ? '' : widget.item.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                widget.item.thumb != null
                    ? Container(
                        height: 280,
                        decoration: BoxDecoration(
                          boxShadow: [shadow],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CachedNetworkImage(
                                  imageUrl: baseUrl + widget.item.thumb,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                    baseUrl +
                                        "/assets/youth/images/noImage.jpg",
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                )),
                          ],
                        ),
                      )
                    : Container(
                        height: 136,
                        child: Image.network(
                          baseUrl + "/assets/youth/images/noImage.jpg",
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                Container(
                  child: Html(
                    data: widget.item.content,
                    style: {
                      "p": Style(
                        textAlign: TextAlign.justify,
                        lineHeight: LineHeight(1.5),
                      ),
                    },
                  ),
                ),
                Container(
                  height: 90,
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
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
                              Icons.access_time,
                              color: knowLedgeColor,
                              size: 14.0,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.item.createdAt == null
                                  ? ''
                                  : DateFormat("y-MM-dd")
                                      .format(
                                        DateTime.parse(widget.item.createdAt),
                                      )
                                      .toString(),
                              style: TextStyle(
                                color: knowLedgeColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
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
