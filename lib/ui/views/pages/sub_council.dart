import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/ui/components/sub_button.dart';
import 'package:youth/ui/views/pages/subCouncil/introduction.dart';
import 'package:youth/ui/views/pages/subCouncil/news_list.dart';
import 'package:youth/ui/views/pages/subCouncil/report_list.dart';
import 'package:youth/ui/views/pages/subCouncil/resolution_list.dart';
import 'package:youth/ui/views/pages/subCouncil/staff_list.dart';

import '../../../size_config.dart';

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
                        widget.item.name,
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
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
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
      ),
    );
  }
}
