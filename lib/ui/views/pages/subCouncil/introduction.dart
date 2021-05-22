import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';

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
            DefaultSliverAppBar(
              title: widget.item.name,
              size: size,
              color: Color(0xFF409EFF),
              svgData: "assets/images/svg/page-heading-legal.svg",
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
