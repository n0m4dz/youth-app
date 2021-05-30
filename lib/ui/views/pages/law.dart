import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/font_awesome.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/ui/views/pages/lawDetail.dart';
import 'package:youth/ui/views/pages/partTimeJobDetail.dart';
import 'package:youth/ui/views/pages/volunteerWorkDetail.dart';

class LawPage extends StatefulWidget {
  final title;

  const LawPage({Key key, this.title}) : super(key: key);

  @override
  LawPageState createState() => LawPageState();
}

class LawPageState extends State<LawPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<dynamic> jobs = new List();
  NetworkUtil _http = new NetworkUtil();
  int page = 1;
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future getItemList() async {
    var url = baseUrl + '/mobile/api/getLegals?page=' + page.toString();
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
              DefaultSliverAppBar(
                title: widget.title,
                size: size,
                color: lawColor,
                svgData: "assets/images/svg/page-heading-law.svg",
              ),
            ];
          },
          body: Container()),
    );
    // return Scaffold(
    //   backgroundColor: Colors.grey[100],
    //   body: NestedScrollView(
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           expandedHeight: 200.0,
    //           floating: false,
    //           pinned: true,
    //           backgroundColor: lawColor,
    //           flexibleSpace: FlexibleSpaceBar(
    //             titlePadding: EdgeInsets.only(right: 90),
    //             centerTitle: true,
    //             title: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Flexible(
    //                   flex: 3,
    //                   child: Container(),
    //                 ),
    //                 Flexible(
    //                   flex: 2,
    //                   child: Text(
    //                     widget.title.toUpperCase(),
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //                 Flexible(
    //                   flex: 1,
    //                   child: Container(),
    //                 ),
    //               ],
    //             ),
    //             background: Stack(
    //               children: [
    //                 Positioned(
    //                   left: -300,
    //                   bottom: 40,
    //                   child: SvgPicture.asset(
    //                     "assets/images/svg/page-heading-law.svg",
    //                     width: size.width,
    //                     height: size.height * .20,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ];
    //     },
    //     body: Container(
    //       height: size.height * 0.7,
    //       child: SmartRefresher(
    //         enablePullDown: true,
    //         enablePullUp: true,
    //         header: WaterDropHeader(
    //           complete: Container(),
    //           completeDuration: Duration(milliseconds: 100),
    //           waterDropColor: secondaryColor,
    //         ),
    //         footer: ClassicFooter(
    //           idleText: "Цааш үзэх",
    //           loadingText: "Түр хүлээнэ үү",
    //           noDataText: "Цааш мэдээлэл байхгүй",
    //           textStyle: TextStyle(color: Color(0xff666666)),
    //         ),
    //         controller: _refreshController,
    //         onRefresh: () async {
    //           setState(() {
    //             this.page = 1;
    //             this.jobs = new List();
    //           });
    //           await this.getItemList();
    //           await Future.delayed(Duration(milliseconds: 1000));
    //           _refreshController.refreshCompleted();
    //         },
    //         onLoading: () async {
    //           setState(() {
    //             this.page = this.page + 1;
    //           });
    //           await this.getItemList();
    //           await Future.delayed(Duration(milliseconds: 1000));
    //           _refreshController.loadComplete();
    //         },
    //         child: ListView(
    //           shrinkWrap: true,
    //           children: jobs.map(
    //             (item) {
    //               index = index + 1;
    //               return GestureDetector(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => LawDetailPage(
    //                         title: item['title'],
    //                         thumb: item['thumb'],
    //                         body: item['body'],
    //                         link: item['link'],
    //                         type: item['type'],
    //                         views: item['views'],
    //                         created_at: item['created_at'],
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Container(
    //                   width: size.width - 40,
    //                   margin:
    //                       EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //                   decoration: BoxDecoration(
    //                     border: Border.all(
    //                       color: lawColor.withOpacity(0.3),
    //                       width: 1,
    //                       style: BorderStyle.solid,
    //                     ),
    //                     borderRadius: BorderRadius.circular(8),
    //                   ),
    //                   child: Stack(
    //                     children: [
    //                       Column(
    //                         children: [
    //                           Container(
    //                             width: size.width - 40,
    //                             height: 150,
    //                             decoration: BoxDecoration(
    //                               border: Border(
    //                                 bottom: BorderSide(
    //                                   color: Color.fromRGBO(67, 35, 167, 0.3),
    //                                   width: 1,
    //                                 ),
    //                               ),
    //                             ),
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.only(
    //                                 topRight: Radius.circular(8),
    //                                 topLeft: Radius.circular(8),
    //                               ),
    //                               // child: Image.network(
    //                               //   item['thumb'] == null
    //                               //       ? baseUrl +
    //                               //           "/assets/youth/images/noImage.jpg"
    //                               //       : baseUrl + item['thumb'].toString(),
    //                               //   height: MediaQuery.of(context).size.height,
    //                               //   width: size.width,
    //                               //   fit: BoxFit.fitWidth,
    //                               // ),
    //                               child: Container(
    //                                 child: Column(
    //                                   children: [
    //                                     item['image'] != null
    //                                         ? Container(
    //                                             height: 90,
    //                                             child: CachedNetworkImage(
    //                                               imageUrl: item['thumb'],
    //                                               imageBuilder: (context,
    //                                                       imageProvider) =>
    //                                                   Container(
    //                                                 decoration: BoxDecoration(
    //                                                   image: DecorationImage(
    //                                                     image: imageProvider,
    //                                                     fit: BoxFit.cover,
    //                                                   ),
    //                                                   borderRadius:
    //                                                       BorderRadius.circular(
    //                                                           15),
    //                                                 ),
    //                                               ),
    //                                               placeholder: (context, url) =>
    //                                                   Container(
    //                                                 child: Center(
    //                                                   child:
    //                                                       CircularProgressIndicator(
    //                                                           strokeWidth: 2),
    //                                                 ),
    //                                               ),
    //                                               errorWidget:
    //                                                   (context, url, error) =>
    //                                                       Image.network(
    //                                                 baseUrl +
    //                                                     "/assets/youth/images/noImage.jpg",
    //                                                 width: 200,
    //                                                 fit: BoxFit.fitWidth,
    //                                               ),
    //                                             ),
    //                                           )
    //                                         : Container(
    //                                             margin:
    //                                                 EdgeInsets.only(top: 30),
    //                                             height: 90,
    //                                             child: Image.network(
    //                                               baseUrl +
    //                                                   "/assets/youth/images/noImage.jpg",
    //                                               width: 200,
    //                                               fit: BoxFit.fitWidth,
    //                                             ),
    //                                           ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             width: size.width - 40,
    //                             height: 165,
    //                             decoration: BoxDecoration(
    //                               color: Colors.white,
    //                               borderRadius: BorderRadius.only(
    //                                 bottomRight: Radius.circular(8),
    //                                 bottomLeft: Radius.circular(8),
    //                               ),
    //                             ),
    //                             child: Column(
    //                               children: [
    //                                 Container(
    //                                   padding: EdgeInsets.only(
    //                                     left: 10,
    //                                     top: 10,
    //                                     right: 10,
    //                                   ),
    //                                   alignment: Alignment.centerLeft,
    //                                   child: Flex(
    //                                     direction: Axis.horizontal,
    //                                     children: [
    //                                       Flexible(
    //                                         child: Text(
    //                                           item['title'] == null
    //                                               ? ''
    //                                               : item['title'],
    //                                           overflow: TextOverflow.ellipsis,
    //                                           maxLines: 1,
    //                                           softWrap: false,
    //                                           style: TextStyle(
    //                                             color: lawColor,
    //                                             fontWeight: FontWeight.bold,
    //                                             fontSize: 18,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   height: 90,
    //                                   margin: EdgeInsets.only(
    //                                     left: 10,
    //                                     right: 10,
    //                                     top: 30,
    //                                     bottom: 10,
    //                                   ),
    //                                   decoration: BoxDecoration(
    //                                     border: Border(
    //                                       top: BorderSide(
    //                                         color: Colors.grey,
    //                                         width: 1,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   child: Column(
    //                                     children: [
    //                                       Container(
    //                                         padding: EdgeInsets.only(
    //                                             top: 10, bottom: 10),
    //                                         width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width -
    //                                             25,
    //                                         child: Row(
    //                                           children: [
    //                                             Icon(
    //                                               Icons.calendar_today,
    //                                               color: lawColor,
    //                                               size: 14.0,
    //                                             ),
    //                                             SizedBox(width: 5),
    //                                             Text(
    //                                               'Хуулийн төрөл: ',
    //                                               style: TextStyle(
    //                                                 color: Colors.black54,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                             Text(
    //                                               item['type'] == null
    //                                                   ? ''
    //                                                   : item['type'].toString(),
    //                                               style: TextStyle(
    //                                                 color: lawColor,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.only(
    //                                             top: 0, bottom: 10),
    //                                         width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width -
    //                                             25,
    //                                         child: Row(
    //                                           children: [
    //                                             Icon(Icons.access_time,
    //                                                 color: lawColor,
    //                                                 size: 14.0),
    //                                             SizedBox(width: 5),
    //                                             Text(
    //                                               'Нэмсэн огноо: ',
    //                                               style: TextStyle(
    //                                                 color: Colors.black54,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                             Text(
    //                                               item['created_at'] == null
    //                                                   ? ''
    //                                                   : DateFormat("y/MM/dd")
    //                                                       .format(
    //                                                         DateTime.parse(
    //                                                           item[
    //                                                               'created_at'],
    //                                                         ),
    //                                                       )
    //                                                       .toString(),
    //                                               style: TextStyle(
    //                                                 color: lawColor,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       Container(
    //                                         padding: EdgeInsets.only(
    //                                           top: 0,
    //                                           bottom: 5,
    //                                         ),
    //                                         width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width -
    //                                             25,
    //                                         child: Row(
    //                                           children: [
    //                                             Icon(
    //                                               Icons.supervised_user_circle,
    //                                               color: lawColor,
    //                                               size: 14.0,
    //                                             ),
    //                                             SizedBox(width: 5),
    //                                             Text(
    //                                               'Үзсэн тоо: ',
    //                                               style: TextStyle(
    //                                                 color: Colors.black54,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                             Text(
    //                                               item['views'] == null
    //                                                   ? '__'
    //                                                   : item['views']
    //                                                       .toString(),
    //                                               style: TextStyle(
    //                                                 color: lawColor,
    //                                                 fontWeight: FontWeight.w500,
    //                                                 fontSize: 14,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           ).toList(),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Color.fromRGBO(179, 56, 56, 1);
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
