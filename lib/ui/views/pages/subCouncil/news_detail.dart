import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/contants/values.dart';
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
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: primaryColor.withOpacity(0.9),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  widget.news.thumb == null
                      ? baseUrl + "/assets/youth/images/noImage.jpg"
                      : baseUrl + widget.news.thumb.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 1,
                  color: Colors.grey.withOpacity(0.23),
                )
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Text(
                  widget.news.title == null ? '' : widget.news.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Html(
                    data: widget.news.content.toString(),
                    style: {
                      "p": Style(
                        color: kTextColor,
                        fontSize: FontSize(13),
                        fontWeight: FontWeight.normal,
                      ),
                    },
                  ),
                ),
                Column(
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
                            'Нэмсэн огноо: ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.news.createdAt,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
