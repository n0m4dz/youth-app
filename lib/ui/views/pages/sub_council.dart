import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class SubCouncil extends StatefulWidget {
  final String title;

  const SubCouncil({Key key, this.title}) : super(key: key);
  @override
  _SubCouncilState createState() => _SubCouncilState();
}

class _SubCouncilState extends State<SubCouncil> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;

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
                          fontSize: getProportionateScreenWidth(20),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsetsDirectional.only(top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: FlatButton(
                  child: Text(
                    'Танилцуулга',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: FlatButton(
                  child: Text(
                    'Гишүүд',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: FlatButton(
                  child: Text(
                    'Мэдээ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: FlatButton(
                  child: Text(
                    'Тогтоол',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: FlatButton(
                  child: Text(
                    'Тайлан',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
