import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:youth/core/models/youth_council.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/components/sub_button.dart';
import 'package:youth/ui/views/pages/subYouthCouncil/youth_introduction.dart';
import 'package:youth/ui/views/pages/subYouthCouncil/youth_plan.dart';
import 'package:youth/ui/views/pages/subYouthCouncil/youth_tips.dart';
import 'package:youth/ui/views/pages/subYouthCouncil/youth_volunteer.dart';
import 'package:youth/ui/views/pages/subCouncil/news_list.dart';
import 'package:youth/ui/views/pages/subCouncil/report_list.dart';
import 'package:youth/ui/views/pages/subYouthCouncil/youth_event.dart';
import 'package:youth/ui/views/pages/subCouncil/staff_list.dart';

class SubYouthCouncil extends StatefulWidget {
  final YouthCouncil item;

  const SubYouthCouncil({Key key, this.item}) : super(key: key);
  @override
  _SubCouncilState createState() => _SubCouncilState();
}

class _SubCouncilState extends State<SubYouthCouncil> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
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
                    child: QrImage(
                      data: widget.item.qr,
                      version: QrVersions.auto,
                      size: 150.0,
                    ),
                  ),
                  SizedBox(height: 10),
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
                    title: "Эвэнт",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YouthEventPage(
                            aimagId: widget.item.id,
                          ),
                        ),
                      );
                    },
                    icon: FontAwesomeIcons.calendarPlus,
                  ),
                  SubButton(
                    title: "Сайн дурын ажил",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YouthVolunteerWorks(
                            aimagId: widget.item.id,
                          ),
                        ),
                      );
                    },
                    icon: FontAwesomeIcons.handshake,
                  ),
                  SubButton(
                    title: "Төлөвлөгөө",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YouthPlan(
                            aimagId: widget.item.id,
                          ),
                        ),
                      );
                    },
                    icon: FontAwesomeIcons.clipboardList,
                  ),
                  SubButton(
                    title: "Зөвлөмж",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YouthTips(
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
