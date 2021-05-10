import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/font_awesome.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/ui/views/pages/partTimeJobDetail.dart';

import '../../styles/_colors.dart';

class PartTimeJobPage extends StatefulWidget {
  final title;

  const PartTimeJobPage({Key key, this.title}) : super(key: key);

  @override
  PartTimeJobPageState createState() => PartTimeJobPageState();
}

class PartTimeJobPageState extends State<PartTimeJobPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<dynamic> jobs = new List();
  NetworkUtil _http = new NetworkUtil();
  int page = 1;
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future getItemList() async {
    var url = baseUrl + '/mobile/api/getJobs/null?page=' + page.toString();
    var response = await _http.get(url);
    var response_data = response.data['data'];
    var totalPage;

    totalPage =
        (response_data['total'] / response_data['per_page']).round() + 1;

    if (totalPage >= page) {
      var parsed = response_data['data'] as List<dynamic>;
      for (var item in parsed) {
        jobs.add(item);
      }
    }
    setState(() {});
  }

  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = 0;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: partTimeColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(right: 150),
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        widget.title.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                background: Stack(
                  children: [
                    Positioned(
                      left: -270,
                      bottom: 40,
                      child: SvgPicture.asset(
                        "assets/images/svg/page-heading-part-time.svg",
                        width: size.width,
                        height: size.height * .20,
                      ),
                    ),
                  ],
                ),
              ),
              // title: Text(widget.title.toUpperCase()),
            ),
          ];
        },
        body: Container(
          height: size.height * 0.7,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(
              complete: Container(),
              completeDuration: Duration(milliseconds: 100),
              waterDropColor: secondaryColor,
            ),
            footer: ClassicFooter(
              idleText: "Цааш үзэх",
              loadingText: "Түр хүлээнэ үү",
              noDataText: "Цааш мэдээлэл байхгүй",
              textStyle: TextStyle(color: Color(0xff666666)),
            ),
            controller: _refreshController,
            onRefresh: () async {
              setState(() {
                this.page = 1;
                this.jobs = new List();
              });
              await this.getItemList();
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              setState(() {
                this.page = this.page + 1;
              });
              await this.getItemList();
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.loadComplete();
            },
            child: ListView(
              shrinkWrap: true,
              children: jobs.map(
                (item) {
                  index = index + 1;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartTimeJobDetailPage(
                            title: item['title'],
                            description: item['description'],
                            date: item['duedate'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15.0,
                      ),
                      width: MediaQuery.of(context).size.width - 40.0,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.lightGreen,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.3,
                                height: size.height,
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      right: BorderSide(
                                          width: 2.0, color: Colors.yellow),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: SvgPicture.asset(
                                          'assets/images/svg/icon-part-time.svg',
                                          semanticsLabel: 'A red up arrow',
                                          fit: BoxFit.contain,
                                          color: Colors.green,
                                          width: 53,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'ЦАГИЙН \n АЖИЛ:',
                                            style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width * 0.7 - 40,
                                height: size.height,
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 25),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item['title'],
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              item['description'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, bottom: 25),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.brown,
                                            size: 14.0,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            DateFormat("y/MM/dd")
                                                .format(
                                                  DateTime.parse(
                                                    item['duedate'],
                                                  ),
                                                )
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // Positioned(
                          //   bottom: 5,
                          //   right: 10,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => PartTimeJobDetailPage(
                          //             title: item['title'],
                          //             description: item['description'],
                          //             date: item['duedate'],
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //     child: Row(
                          //       children: [
                          //         Container(
                          //           padding: EdgeInsets.only(
                          //             bottom:
                          //                 3, // space between underline and text
                          //           ),
                          //           decoration: BoxDecoration(
                          //             border: Border(
                          //               bottom: BorderSide(
                          //                 color:
                          //                     Colors.yellow, // Text colour here
                          //                 width: 2.0, // Underline width
                          //               ),
                          //             ),
                          //           ),
                          //           child: Text(
                          //             'Ца'.toUpperCase(),
                          //             style: TextStyle(
                          //                 color: Colors.green, fontSize: 14),
                          //           ),
                          //         ),
                          //         Container(
                          //           padding: EdgeInsets.only(
                          //             bottom:
                          //                 3, // space between underline and text
                          //           ),
                          //           decoration: BoxDecoration(
                          //             border: Border(
                          //               bottom: BorderSide(
                          //                 color:
                          //                     Colors.white, // Text colour here
                          //                 width: 2.0, // Underline width
                          //               ),
                          //             ),
                          //           ),
                          //           child: Text(
                          //             'аш үзэх'.toUpperCase(),
                          //             style: TextStyle(
                          //                 color: Colors.green, fontSize: 14),
                          //           ),
                          //         ),
                          //         Container(
                          //           padding: EdgeInsets.only(
                          //             bottom:
                          //                 3, // space between underline and text
                          //           ),
                          //           decoration: BoxDecoration(
                          //             border: Border(
                          //               bottom: BorderSide(
                          //                 color:
                          //                     Colors.white, // Text colour here
                          //                 width: 2.0, // Underline width
                          //               ),
                          //             ),
                          //           ),
                          //           child: Icon(
                          //             FontAwesome.getIconData(
                          //                 'angle-double-right'),
                          //             color: Colors.green,
                          //             size: 18.0,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
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
