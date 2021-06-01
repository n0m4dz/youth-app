import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/volunteer_work.dart';
import 'package:youth/core/viewmodels/volunteer_work_model.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/components/empty_items.dart';
import 'package:youth/ui/components/loader.dart';
import 'package:youth/ui/styles/_colors.dart';

import '../../../../size_config.dart';
import '../../base_view.dart';

class VolunteerWorks extends StatefulWidget {
  final String title;

  const VolunteerWorks({Key key, this.title}) : super(key: key);

  @override
  _VolunteerWorksState createState() => _VolunteerWorksState();
}

class _VolunteerWorksState extends State<VolunteerWorks> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            DefaultSliverAppBar(
              title: widget.title,
              size: size,
              color: volunteerColor,
              svgData: "assets/images/svg/page-heading-legal.svg",
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              height: 200,
              alignment: Alignment.center,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [shadow],
              ),
              child: Text('Тун удахгүй'),
            ),
          ],
        ),
      ),
    );
  }
}
