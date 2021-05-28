import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/components/sub_button.dart';
import 'package:youth/ui/views/pages/subCouncil/introduction.dart';
import 'package:youth/ui/views/pages/subCouncil/news_list.dart';
import 'package:youth/ui/views/pages/subCouncil/report_list.dart';
import 'package:youth/ui/views/pages/subCouncil/resolution_list.dart';
import 'package:youth/ui/views/pages/subCouncil/staff_list.dart';

class SubCouncil extends StatefulWidget {
  final NationalCouncil item;

  const SubCouncil({Key key, this.item}) : super(key: key);
  @override
  _SubCouncilState createState() => _SubCouncilState();
}

class _SubCouncilState extends State<SubCouncil> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF54a0ff),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/ux_big.png"),
          //   alignment: Alignment.topRight,
          // ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 40, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: QrImage(
                          backgroundColor: Colors.white,
                          data: widget.item.qr,
                          version: QrVersions.auto,
                          size: 80.0,
                        ),
                      )
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
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SubButton(
                              title: "Танилцуулга",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Introduction(
                                      item: widget.item,
                                    ),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.addressBook,
                            ),
                            SubButton(
                              title: "Гишүүд",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StaffList(
                                      aimagId: widget.item.id,
                                    ),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.users,
                            ),
                            SubButton(
                              title: "Мэдээ",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsList(
                                      aimagId: widget.item.id,
                                    ),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.newspaper,
                            ),
                            SubButton(
                              title: "Тогтоол",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResolutionList(
                                      aimagId: widget.item.id,
                                    ),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.solidNewspaper,
                            ),
                            SubButton(
                              title: "Тайлан",
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportList(
                                      aimagId: widget.item.id,
                                    ),
                                  ),
                                );
                              },
                              icon: FontAwesomeIcons.arrowDown,
                            ),
                          ],
                        ),
                      ),
                    ),
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
