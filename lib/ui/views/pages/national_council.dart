import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/ui/components/loader.dart';
import 'package:youth/ui/views/base_view.dart';
import 'package:youth/core/viewmodels/national_council_model.dart';

class NationalCouncilPage extends StatefulWidget {
  final title;

  const NationalCouncilPage({Key key, this.title}) : super(key: key);

  @override
  NationalCouncilPageState createState() => NationalCouncilPageState();
}

class NationalCouncilPageState extends State<NationalCouncilPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<dynamic> jobs = new List();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = 0;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xFF38ada9),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                    ],
                  ),
                  // background: Stack(
                  //   children: [
                  //     Positioned(
                  //       left: -270,
                  //       bottom: 40,
                  //       child: SvgPicture.asset(
                  //         "assets/images/svg/page-heading-part-time.svg",
                  //         width: size.width,
                  //         height: size.height * .20,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                // title: Text(widget.title.toUpperCase()),
              ),
            ];
          },
          body: BaseView<NationalCouncilModel>(
            onModelReady: (model) {
              model.getNationalList();
            },
            builder: (context, model, child) => model.loading
                ? Loader()
                : ListView(
                    padding: EdgeInsets.only(top: 20, bottom: 0),
                    children: model.nationalCouncilList.map(
                      (NationalCouncil item) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15.0,
                          ),
                          padding: EdgeInsets.all(20),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFF38ada9),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item.name.toUpperCase()),
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
