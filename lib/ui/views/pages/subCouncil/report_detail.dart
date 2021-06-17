import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/resolution.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/pages/subCouncil/report_list.dart';

class ReportDetail extends StatefulWidget {
  final Resolution item;

  const ReportDetail({Key key, this.item}) : super(key: key);
  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF981d5e),
          image: DecorationImage(
            image: AssetImage("assets/images/bg-purple.jpg"),
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
                          widget.item.title,
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
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      widget.item.thumb != null
                          ? Image.network(
                              baseUrl + widget.item.thumb.toString(),
                            )
                          : Text(''),
                      SizedBox(height: 10),
                      widget.item.body != null
                          ? Html(
                              data: widget.item.body.toString(),
                              style: {
                                "p": Style(
                                  color: kTextColor,
                                  fontSize: FontSize(13),
                                  fontWeight: FontWeight.normal,
                                  textAlign: TextAlign.center,
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
            ),
          ],
        ),
      ),
    );
  }
}
