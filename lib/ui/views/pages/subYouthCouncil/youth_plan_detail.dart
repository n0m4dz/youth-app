import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/resolution.dart';
import 'package:youth/ui/styles/_colors.dart';

class YouthPlanDetail extends StatefulWidget {
  final Resolution item;

  const YouthPlanDetail({Key key, this.item}) : super(key: key);
  @override
  _YouthPlanDetailState createState() => _YouthPlanDetailState();
}

class _YouthPlanDetailState extends State<YouthPlanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  widget.item.thumb == null
                      ? baseUrl + "/assets/youth/images/noImage.jpg"
                      : baseUrl + widget.item.thumb.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text(
                widget.item.title == null ? '' : widget.item.title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                //child: Html(data: widget.news.content),
                child: Html(
                  data: widget.item.thumb.toString(),
                  style: {
                    "p": Style(
                      color: kTextColor,
                      fontSize: FontSize(13),
                      fontWeight: FontWeight.normal,
                    ),
                  },
                ),
              ),
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
                            widget.item.createdAt,
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
    );
  }
}
