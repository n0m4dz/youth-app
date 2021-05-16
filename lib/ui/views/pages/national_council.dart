import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/ui/components/dynamic_flexible_spacebar_title.dart';
import 'package:youth/ui/components/loader.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/base_view.dart';
import 'package:youth/core/viewmodels/national_council_model.dart';

import '../notifications.dart';

class NationalCouncilPage extends StatefulWidget {
  final title;

  const NationalCouncilPage({Key key, this.title}) : super(key: key);

  @override
  NationalCouncilPageState createState() => NationalCouncilPageState();
}

class NationalCouncilPageState extends State<NationalCouncilPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        child: Container(
          child: BaseView<NationalCouncilModel>(
            onModelReady: (model) {
              model.getNationalList();
            },
            builder: (context, model, child) => model.loading
                ? Loader()
                : ListView(
                    padding: EdgeInsets.only(top: 20, bottom: 0),
                    children: model.nationalCouncilList.map(
                      (NationalCouncil item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: FlatButton(
                            padding: EdgeInsets.all(20),
                            color: Color(0xFF000000).withOpacity(.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                item.logo != null
                                    ? Container(
                                        child: CachedNetworkImage(
                                          imageUrl: item.logo,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                            baseUrl +
                                                "/assets/youth/images/noImage.jpg",
                                            width: 60,
                                          ),
                                        ),
                                      )
                                    : Image.network(
                                        baseUrl +
                                            "/assets/youth/images/noImage.jpg",
                                        width: 60,
                                      ),
                                // Image.network(
                                //   baseUrl + "/assets/youth/images/noImage.jpg",
                                //   width: 60,
                                // ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(item.name),
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
                      },
                    ).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
