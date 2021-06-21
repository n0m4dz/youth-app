import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/aimag_news.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:flutter/rendering.dart';

class NewsDetail extends StatefulWidget {
  final AimagNews news;

  const NewsDetail({Key key, this.news}) : super(key: key);
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF0a9947),
          image: DecorationImage(
            image: AssetImage("assets/images/bg-green.jpg"),
            alignment: Alignment.topRight,
            //fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 180,
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
                      Expanded(
                        child: Text(
                          widget.news.title,
                          style: TextStyle(
                            fontSize: 16,
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
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: bgColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      widget.news.thumb != null
                          ? Image.network(
                              baseUrl + widget.news.thumb.toString(),
                            )
                          : Text(''),
                      SizedBox(height: 10),
                      widget.news.description != null
                          ? Html(
                              data: widget.news.description.toString(),
                              style: {
                                "p": Style(
                                  color: kTextColor,
                                  fontSize: FontSize(13),
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.justify,
                                ),
                              },
                            )
                          : Text(''),
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 30,
                          bottom: 10,
                        ),
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
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Color(0xFF0a9947),
                                    size: 14.0,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.news.createdAt,
                                    style: TextStyle(
                                      color: Color(0xFF0a9947),
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
          ],
        ),
      ),
    );
  }
}
