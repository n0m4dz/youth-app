import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/national_council.dart';

import '../../../../size_config.dart';

class Introduction extends StatefulWidget {
  final NationalCouncil item;

  const Introduction({Key key, this.item}) : super(key: key);
  @override
  _Introduction createState() => _Introduction();
}

class _Introduction extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: getProportionateScreenHeight(200),
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFF409EFF),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Танилцуулга",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                background: Stack(
                  children: [
                    Positioned(
                      right: getProportionateScreenWidth(-50),
                      bottom: 0,
                      child: SvgPicture.asset(
                        "assets/images/svg/page-heading-legal.svg",
                        width: size.width,
                        height: size.height * getProportionateScreenWidth(.13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: widget.item.introduction != null
            ? Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(15),
                ),
                child: Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(15),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.23),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Html(
                    data: widget.item.introduction.toString(),
                    style: {
                      "p": Style(
                        color: kTextColor,
                        fontSize: FontSize(14),
                      ),
                    },
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(15),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(15),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        color: Colors.grey.withOpacity(0.23),
                      )
                    ],
                  ),
                  child: Text(
                    'Мэдээлэл байхгүй байна.',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
