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
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF409EFF),
      //   bottomOpacity: 0.0,
      //   elevation: 0.0,
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF409EFF),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/ux_big.png"),
          //   alignment: Alignment.topRight,
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 5, top: 40, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.item.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: widget.item.introduction != null
                    ? Html(
                        data: widget.item.introduction.toString(),
                        style: {
                          "p": Style(
                            color: kTextColor,
                            fontSize: FontSize(14),
                          ),
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.all(
                          getProportionateScreenWidth(15),
                        ),
                        child: Text(
                          'Мэдээлэл байхгүй байна',
                          style: TextStyle(
                            color: kTextColor,
                          ),
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

class SubButton extends StatelessWidget {
  final String title;
  const SubButton({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(10),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(15),
        onPressed: () {},
        color: Color(0xFFCCCCCC).withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(10),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF000000).withOpacity(.5),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
