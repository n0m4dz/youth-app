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
import 'package:youth/core/viewmodels/aimag_model.dart';
import 'package:youth/ui/components/dynamic_flexible_spacebar_title.dart';
import 'package:youth/ui/components/loader.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/base_view.dart';
import 'package:youth/core/viewmodels/national_council_model.dart';
import 'dart:math';

class NationalCouncilPage extends StatefulWidget {
  final title;

  const NationalCouncilPage({Key key, this.title}) : super(key: key);
  @override
  _NationalCouncilPageState createState() => _NationalCouncilPageState();
}

class _NationalCouncilPageState extends State<NationalCouncilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SearchHeader(
              /*icon: Icons.terrain,*/
              title: 'Залуучууд Хөгжлийн\n Үндэсний зөвлөл',
              search: _Search(),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: BaseView<NationalCouncilModel>(
              onModelReady: (model) {
                model.getNationalList();
              },
              builder: (context, model, child) => model.loading
                  ? Loader()
                  : ListView(
                      physics: NeverScrollableScrollPhysics(),
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
                                              width: 60,
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
          )
        ],
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
              // textAlignVertical: TextAlignVertical.center,
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
                  })
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

class SearchHeader extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 100;
  final double maxTopBarHeight = 200;
  final String title;
  final IconData icon;
  final Widget search;

  SearchHeader({
    @required this.title,
    this.icon,
    this.search,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));

    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height:
            max(maxTopBarHeight * (1 - shrinkFactor * 1.45), minTopBarHeight),
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xFF38ada9),
        ),
      ),
    );
    return Container(
      height: max(maxExtent - shrinkOffset, minExtent),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: search,
                    width: 245,
                    height: 45,
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
                          /*return BaseView<AimagModel>(
                              onModelReady: (model) {
                            model.getAimagModelList();
                          },
                          builder: (context, model, child) => model.loading
                          ? Loader()
                          : ListView(
                              children: model.getAimagModelList.map(
                                (Aimag item) {
                                  return Text('ok done');
                                }
                              );
                            ),
                          );*/
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /*ListTile(
                                leading: new Icon(Icons.photo),
                                title: new Text('Photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),*/
                              Container(
                                child: Text('1'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    padding: EdgeInsets.all(14),
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
          ),
          if (shrinkFactor > 0.5) topBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class CourseContent extends StatelessWidget {
  final String number, title;
  final double duration;
  final bool isDone;

  const CourseContent({
    Key key,
    this.number,
    this.title,
    this.duration,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(title),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF000000).withOpacity(.5),
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}
