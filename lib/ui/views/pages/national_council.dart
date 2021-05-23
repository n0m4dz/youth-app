import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/aimag.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/core/viewmodels/aimag_model.dart';
import 'package:youth/core/viewmodels/national_council_model.dart';
import 'package:youth/size_config.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/components/loader.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:youth/ui/views/pages/sub_council.dart';

import '../base_view.dart';

class NationalCouncilPage extends StatefulWidget {
  final title;

  const NationalCouncilPage({Key key, this.title}) : super(key: key);

  @override
  _NationalCouncilPageState createState() => _NationalCouncilPageState();
}

class _NationalCouncilPageState extends State<NationalCouncilPage> {
  TextEditingController _editingController;
  String _searchValue;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

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
            DefaultSliverAppBar(
              title: widget.title,
              size: size,
              color: Color(0xFF409EFF),
              svgData: "assets/images/svg/page-heading-legal.svg",
            ),
          ];
        },
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ),
            Expanded(
              child: BaseView<NationalCouncilModel>(
                onModelReady: (model) {
                  model.getNationalList(search: _searchValue);
                },
                builder: (context, model, child) => model.loading
                    ? Loader()
                    : ListView(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
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
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 5),
                                  child: Expanded(
                                    child: TextField(
                                      controller: _editingController,
                                      onChanged: model.searchTrack,
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
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    buildShowModalBottomSheet(context);
                                  },
                                  padding: EdgeInsets.all(
                                      getProportionateScreenWidth(14)),
                                  color: Colors.white,
                                  child: Text(
                                    'Байршил',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: model.nationalCouncilList.map(
                              (NationalCouncil item) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            getProportionateScreenWidth(15),
                                        vertical:
                                            getProportionateScreenHeight(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.23),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: FlatButton(
                                          padding: EdgeInsets.all(
                                            getProportionateScreenWidth(20),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubCouncil(item: item),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              item.logo != null
                                                  ? Container(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            baseUrl + item.logo,
                                                        width: 64,
                                                        height: 64,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.network(
                                                          baseUrl +
                                                              "/assets/youth/images/noImage.jpg",
                                                          width: 64,
                                                        ),
                                                      ),
                                                    )
                                                  : Image.network(
                                                      baseUrl +
                                                          "/assets/youth/images/noImage.jpg",
                                                      width: 64,
                                                    ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Text(item.name),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xFF409EFF),
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
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

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
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
                builder: (context, model, child) => model.loading
                    ? Loader()
                    : ListView(
                        children: model.aimagList.map(
                          (Aimag aimag) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(aimag.ner),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF000000).withOpacity(.5),
                                    size: 15,
                                  ),
                                ],
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
  }
}

// class _Search extends StatefulWidget {
//   _Search({Key key}) : super(key: key);

//   @override
//   __SearchState createState() => __SearchState();
// }

// class __SearchState extends State<_Search> {
//   TextEditingController _editingController;

//   @override
//   void initState() {
//     super.initState();
//     _editingController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 5),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _editingController,
//               onChanged: (value) => setState(
//                 () => {},
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Хайх',
//                 hintStyle: TextStyle(
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//               ),
//             ),
//           ),
//           _editingController.text.trim().isEmpty
//               ? IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: () {},
//                 )
//               : IconButton(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   icon: Icon(
//                     Icons.clear,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: () => setState(
//                     () {
//                       _editingController.clear();
//                     },
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
