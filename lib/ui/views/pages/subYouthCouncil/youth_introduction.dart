import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/youth_council.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/styles/_colors.dart';

import '../../../../size_config.dart';

class Introduction extends StatefulWidget {
  final YouthCouncil item;

  const Introduction({Key key, this.item}) : super(key: key);
  @override
  _Introduction createState() => _Introduction();
}

class _Introduction extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF54a0ff),
          image: DecorationImage(
            image: AssetImage("assets/images/bg-wh.jpg"),
            alignment: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 40,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Танилцуулга',
                          style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [shadow],
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(
                          getProportionateScreenWidth(15),
                        ),
                        child: widget.item.introduction != null
                            ? Column(
                                children: [
                                  Text(
                                    widget.item.name,
                                    style: TextStyle(
                                        fontSize: 18, color: primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Html(
                                    data: widget.item.introduction.toString(),
                                    style: {
                                      "p": Style(
                                        color: kTextColor,
                                        fontSize: FontSize(14),
                                        textAlign: TextAlign.justify,
                                      ),
                                    },
                                  ),
                                ],
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: 150,
                                //color: Colors.white,
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [shadow],
                                ),
                                child: Text(
                                  'Мэдээлэл оруулаагүй байна.',
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
