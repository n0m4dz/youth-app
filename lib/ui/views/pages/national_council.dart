import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/aimag.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/core/viewmodels/aimag_model.dart';
import 'package:youth/core/viewmodels/national_council_model.dart';
import 'package:youth/size_config.dart';
import 'package:youth/ui/components/loader.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youth/ui/views/pages/sub_council.dart';

import '../base_view.dart';

class NationalCouncilPage extends StatefulWidget {
  final title;

  const NationalCouncilPage({Key key, this.title}) : super(key: key);

  @override
  _NationalCouncilPageState createState() => _NationalCouncilPageState();
}

class _NationalCouncilPageState extends State<NationalCouncilPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
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
                        widget.title.toUpperCase(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: _Search(),
                    width: getProportionateScreenWidth(245),
                    height: getProportionateScreenWidth(45),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 1,
                          color: Colors.grey.withOpacity(0.23),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: BaseView<AimagModel>(
                                  onModelReady: (model) {
                                    model.getAimagModelList();
                                  },
                                  builder: (context, model, child) => model
                                          .loading
                                      ? Loader()
                                      : ListView(
                                          children: model.aimagList.map(
                                            (Aimag aimag) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                  vertical: 0,
                                                ),
                                                child: FlatButton(
                                                  onPressed: () {},
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(aimag.ner),
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Color(0xFF000000)
                                                            .withOpacity(.5),
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
                            ],
                          );
                        },
                      );
                    },
                    padding: EdgeInsets.all(getProportionateScreenWidth(14)),
                    color: Colors.white,
                    child: Text(
                      'Байршил',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BaseView<NationalCouncilModel>(
                onModelReady: (model) {
                  model.getNationalList();
                },
                builder: (context, model, child) => model.loading
                    ? Loader()
                    : ListView(
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(20),
                        ),
                        children: model.nationalCouncilList.map(
                          (NationalCouncil item) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15),
                                vertical: getProportionateScreenHeight(10),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(20),
                                ),
                                color: Color(0xFFCCCCCC).withOpacity(.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(15),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SubCouncil(title: item.name),
                                    ),
                                  );
                                },
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
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.network(
                                                baseUrl +
                                                    "/assets/youth/images/noImage.jpg",
                                                width:
                                                    getProportionateScreenWidth(
                                                        60),
                                              ),
                                            ),
                                          )
                                        : Image.network(
                                            baseUrl +
                                                "/assets/youth/images/noImage.jpg",
                                            width: 60,
                                          ),
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
          ],
        ),
      ),
    );
  }
}

class _Search extends StatefulWidget {
  _Search({Key key}) : super(key: key);

  @override
  __SearchState createState() => __SearchState();
}

class __SearchState extends State<_Search> {
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _editingController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Хайх',
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          _editingController.text.trim().isEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    print(123);
                  },
                )
              : IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => setState(
                    () {
                      _editingController.clear();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
